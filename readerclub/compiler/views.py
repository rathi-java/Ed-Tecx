import subprocess
import os
import re
from django.shortcuts import render
from .models import CodeSubmission


def compile_code(request):
    if request.method == "POST":
        language = request.POST.get('language', 'java')  # Default to 'java' if not provided
        code = request.POST.get('code', '')
        input_data = request.POST.get('input_data', '')

        # Save the submission to the database
        submission = CodeSubmission.objects.create(language=language, code=code, input_data=input_data)

        # Create a unique temp directory
        unique_id = submission.id
        temp_dir = f"./temp/{unique_id}"
        os.makedirs(temp_dir, exist_ok=True)
        print(f"Input data: {input_data}")       # Debugging: log input data
        print(f"Temp directory: {temp_dir}")       # Debugging: log temp directory

        # Determine the file name and handle different languages
        if language == 'java':
            # Extract the class name from the code (default to 'Main' if not found)
            match = re.search(r'class\s+(\w+)', code)
            class_name = match.group(1) if match else 'Main'
            code_file = f"{temp_dir}/{class_name}.java"
            # Write the Java code to the file
            with open(code_file, 'w') as f:
                f.write(code)

            # Compile and run Java code
            output = compile_and_run_java(code_file, class_name, input_data, temp_dir)

        elif language == 'python':
            code_file = f"{temp_dir}/Main.py"
            # Write the Python code to the file
            with open(code_file, 'w') as f:
                f.write(code)

            # Run Python code
            output = compile_and_run_python(code_file, input_data)

        elif language == 'javascript':
            code_file = f"{temp_dir}/Main.js"
            # Write the JavaScript code to the file
            with open(code_file, 'w') as f:
                f.write(code)

            # Run JavaScript code using Node.js
            output = compile_and_run_javascript(code_file, input_data)

        else:
            output = "Unsupported language."

        # Save output to database and return result
        submission.output = output
        submission.save()

        return render(request, 'compile_result.html', {
            'output': output,
            'needs_input': False,
            'code': code,
            'input_data': input_data,
            'language': language
        })

    # Default render for GET requests
    return render(request, 'compile_result.html', {'language': 'java'})


def compile_and_run_java(code_file, class_name, input_data, temp_dir):
    try:
        # Compile Java code
        compile_result = subprocess.run(['javac', code_file],
                                        stdout=subprocess.PIPE,
                                        stderr=subprocess.PIPE)
        if compile_result.returncode != 0:
            return compile_result.stderr.decode()

        # Run Java code
        run_result = subprocess.run(['java', '-cp', temp_dir, class_name],
                                    input=input_data.encode(),
                                    stdout=subprocess.PIPE,
                                    stderr=subprocess.PIPE)
        output = run_result.stdout.decode() + '\n' + run_result.stderr.decode()

        return output
    except Exception as e:
        return f"Error during Java execution: {str(e)}"


def compile_and_run_python(code_file, input_data):
    try:
        # Read the Python code to see if input() is used
        with open(code_file, 'r') as file:
            code_content = file.read()

        if 'input(' in code_content:
            # If input() is used, pass the input_data to the process
            run_result = subprocess.run(['python', code_file],
                                        input=input_data.encode(),
                                        stdout=subprocess.PIPE,
                                        stderr=subprocess.PIPE)
        else:
            # Otherwise, run the code without input
            run_result = subprocess.run(['python', code_file],
                                        stdout=subprocess.PIPE,
                                        stderr=subprocess.PIPE)
        output = run_result.stdout.decode() + '\n' + run_result.stderr.decode()
        return output

    except Exception as e:
        return f"Error during Python execution: {str(e)}"


def compile_and_run_javascript(code_file, input_data):
    try:
        # Run JavaScript code using Node.js.
        # If input_data is provided, pass it to the process.
        run_result = subprocess.run(['node', code_file],
                                    input=input_data.encode() if input_data else None,
                                    stdout=subprocess.PIPE,
                                    stderr=subprocess.PIPE)
        output = run_result.stdout.decode() + '\n' + run_result.stderr.decode()
        return output

    except Exception as e:
        return f"Error during JavaScript execution: {str(e)}"
