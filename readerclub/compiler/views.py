import subprocess
import os
import re
from django.shortcuts import render, redirect
from django.contrib import messages
from .models import CodeSubmission, CompilerUsage
from oauth.models import UsersDB


def compile_code(request):
    """
    Standard compiler view - uses traditional form submission with page reload
    Applies usage limits for non-subscribed users
    """
    # Check if user is logged in
    user_id = request.session.get('user_id')
    user = None
    has_subscription = False
    
    if user_id:
        try:
            user = UsersDB.objects.get(id=user_id)
            
            # Check if user has an active subscription
            has_subscription = user.is_subscription_active() if hasattr(user, 'is_subscription_active') else False
            
            # Track usage for all users, but only apply limits to non-subscribed users
            try:
                usage = CompilerUsage.objects.get(user=user)
                if not has_subscription and usage.hit >= 5:
                    messages.warning(request, "You've reached the compiler usage limit. Please upgrade to a subscription plan for unlimited access.")
                    return redirect('price')  # Redirect to home page instead of price page
            except CompilerUsage.DoesNotExist:
                # Create a new usage record if it doesn't exist
                usage = CompilerUsage.objects.create(user=user, hit=0)
        except UsersDB.DoesNotExist:
            pass
    
    # Process submitted code
    if request.method == "POST":
        # Get form data
        language = request.POST.get('language', 'java')
        code = request.POST.get('code', '')
        input_data = request.POST.get('input_data', '')

        # Save the submission to the database
        submission = CodeSubmission.objects.create(language=language, code=code, input_data=input_data)

        # Increment usage counter for all logged-in users
        if user_id and user:
            try:
                # Get the compiler usage record created earlier
                usage = CompilerUsage.objects.get(user=user)
                usage.hit += 1
                usage.save()
                print(f"Updated usage for {user.username}: {usage.hit} hits")  # Debug log
                
                # Only show limit warning to non-subscribed users
                if not has_subscription and usage.hit >= 10:
                    messages.info(request, "This is your last free compiler use. Please upgrade for unlimited access.")
            except Exception as e:
                print(f"Error updating compiler usage: {str(e)}")  # Log error

        # Create a unique temp directory
        unique_id = submission.id
        temp_dir = f"./temp/{unique_id}"
        os.makedirs(temp_dir, exist_ok=True)

        # Process code based on language
        if language == 'java':
            match = re.search(r'class\s+(\w+)', code)
            class_name = match.group(1) if match else 'Main'
            code_file = f"{temp_dir}/{class_name}.java"
            with open(code_file, 'w') as f:
                f.write(code)
            output = compile_and_run_java(code_file, class_name, input_data, temp_dir)
        elif language == 'python':
            code_file = f"{temp_dir}/Main.py"
            with open(code_file, 'w') as f:
                f.write(code)
            output = compile_and_run_python(code_file, input_data)
        elif language == 'javascript':
            code_file = f"{temp_dir}/Main.js"
            with open(code_file, 'w') as f:
                f.write(code)
            output = compile_and_run_javascript(code_file, input_data)
        else:
            output = "Unsupported language."

        # Save output to database
        submission.output = output
        submission.save()

        # Return the full page with results
        return render(request, 'compile_result.html', {
            'output': output,
            'code': code,
            'input_data': input_data,
            'language': language,
        })

    # For GET requests
    return render(request, 'compile_result.html', {
        'language': 'java',
    })


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
