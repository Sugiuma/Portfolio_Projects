# Math Quiz Application

The Math Quiz Application is a Python-based educational program that generates random math problems for users to solve. The app includes a graphical interface created with Tkinter and supports multiple types of problems, including integer and fraction operations. The user can select the number of questions, answer them interactively, and receive real-time feedback with a final score at the end.

## Features
- **Random Problem Generation**: Problems include four-digit addition, four-digit subtraction, three-digit multiplication, and fraction addition, subtraction, and multiplication.
- **Interactive Table Display**: Problems are displayed in a table format with columns for "Problem," "Your Answer," "Result," and "Correct Answer."
- **Real-Time Feedback**: Users get immediate feedback on each answer, and results are displayed in the table.
- **Score Tracking**: A score label updates dynamically as the user answers each problem.
- **Final Quiz Completion Message**: Displays a congratulatory message when the quiz is complete.

## Screenshots
### Initial Quiz Prompt
![Initial Prompt](assets/images/initial_prompt.png)

### Problem Display and Answer Entry
![Problem Display](assets/images/problem_display.png)

### Final Score Display
![Final Score](assets/images/final_score.png)

## Code Structure
- `MathQuizApp`: The main class for the application, responsible for generating problems, displaying the interface, handling answer checks, and updating scores.
- **Problem Generation**: Randomly generates math problems, including fractions and integers.
- **User Feedback and Validation**: Displays real-time feedback for user answers, including handling for invalid inputs.

## Code Snippets
### Initialization and Main Interface
```python
class MathQuizApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Math Quiz")
        self.num_problems = simpledialog.askinteger("Number of Questions", "How many questions would you like?", minvalue=1, maxvalue=10)
        if not self.num_problems:
            self.num_problems = 5
        self.problems = []
        self.correct_count = 0
        self.generate_problems()
