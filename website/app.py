from flask import Flask, render_template, jsonify


# ------------
app = Flask(__name__)


# ------------
@app.route('/')
def site():
    """ Returns the index.html for the site """

    try:
        # Render the frontend
        response = render_template('index.html')

    # If an exception occurs
    except Exception:
        response = jsonify({'success': False})

    # Return the response
    return response


# ------------
if __name__ == '__main__':
    """ Runs the Flask app listening on all interfaces, port 5000 """

    app.run(host='0.0.0.0', port=5000)