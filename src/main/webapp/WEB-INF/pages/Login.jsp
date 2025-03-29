<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }
        h2 {
            margin-bottom: 10px;
            font-size: 24px;
            color: #333;
        }
        p {
            margin-bottom: 20px;
            color: #666;
            font-size: 14px;
        }
        .input-group {
            margin-bottom: 15px;
        }
        .input-group label {
            display: block;
            font-size: 14px;
            margin-bottom: 5px;
            color: #333;
        }
        .input-group input {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .submit-btn {
            width: 100%;
            padding: 10px;
            background: black;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background: #333;
        }
      /* Divider */
		.divider {
		    margin: 15px 0;
		    font-size: 14px;
		    color: #777;
		}
		
		/* Social Buttons */
		.social-buttons button {
		    display: block;
		    width: 100%;
		    margin: 8px 0;
		    padding: 10px;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    font-size: 14px;
		}
		
		/* Google Button */
		.google-btn {
		    background-color: #db4437;
		    color: white;
		}
		
		.google-btn:hover {
		    background-color: #c1351d;
		}
		
		/* OnlyFans Button */
		.onlyfans-btn {
		    background-color: #00aff0;
		    color: white;
		}
		
		.onlyfans-btn:hover {
		    background-color: #008ecf;
		}
		
		/* Yahoo Button */
		.yahoo-btn {
		    background-color: #430297;
		    color: white;
		}
		
		.yahoo-btn:hover {
		    background-color: #2e026d;
		}
		
		/* Login Link */
		.login-link {
		    font-size: 14px;
		    margin-top: 10px;
		}
		
		.login-link a {
		    color: #007bff;
		    text-decoration: none;
		}
		
		.login-link a:hover {
		    text-decoration: underline;
		}

    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome to WattX</h2>
        <p>Register to WattX</p>
        <form action="signup.jsp" method="post">
            <div class="input-group">
                <label for="firstname">First Name</label>
                <input type="text" id="firstname" name="firstname" placeholder="Tyler" required>
            </div>
            <div class="input-group">
                <label for="lastname">Last Name</label>
                <input type="text" id="lastname" name="lastname" placeholder="Durden" required>
            </div>
            <div class="input-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email" placeholder="tyler747@fc.com" required>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="••••••••" required>
            </div>
            <button type="submit" class="submit-btn">Sign up →</button>
        </form>
      <div class="divider">or sign up with</div>

        <div class="social-buttons">
            <button class="google-btn">Sign up with Google</button>
            <button class="yahoo-btn">Sign up with Yahoo</button>
        </div>

        <p class="login-link">Already have an account? <a href="#">Log in</a></p>
    </div>
</body>
</html>
