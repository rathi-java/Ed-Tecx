import subprocess
import os
import re
from django.shortcuts import render
from .models import CodeSubmission
from django.http import HttpResponse

def home(request):
    return HttpResponse("Hello Delta, This is an online coding platform")

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
        print(f"Input data: {input_data}")  # Log input data for debugging
        print(f"Temp directory: {temp_dir}")  # Debugging statement

        # Determine the file name and handle different languages
        if language == 'java':
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

            # Compile and run Python code
            output = compile_and_run_python(code_file, input_data)

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
        compile_result = subprocess.run(['javac', code_file], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
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
        # Check if input() is used in the Python code
        with open(code_file, 'r') as file:
            code_content = file.read()

        if 'input(' in code_content:
            # If input() is used in the code, ensure input_data is passed
            run_result = subprocess.run(['python', code_file], input=input_data.encode(),
                                         stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            output = run_result.stdout.decode() + '\n' + run_result.stderr.decode()
            return output
        else:
            # If no input() is used, just run the code without input
            run_result = subprocess.run(['python', code_file],
                                         stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            output = run_result.stdout.decode() + '\n' + run_result.stderr.decode()
            return output

    except Exception as e:
        return f"Error during Python execution: {str(e)}"
