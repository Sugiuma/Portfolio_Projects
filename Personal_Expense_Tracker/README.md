## Expense Tracker with PDF Data Extraction and Categorization
This Python project extracts and processes expense data from a bank statement PDF, organizes it by category, and exports it to an Excel file. The project reads data from specified PDF pages, applies regex-based parsing to extract relevant information, categorizes expenses, and calculates total spending per category.

## Features
- **PDF Extraction**: Extracts text from specific pages of a bank statement PDF.
- **Expense Parsing**: Utilizes regex to filter and format expense data.
- **Categorization**: Groups expenses into categories (e.g., Grocery, Online Retail, Outside Food).
- **Excel Export**: Writes detailed expenses and summarized data to an Excel sheet.
- **Data Summarization**: Aggregates expenses by category for monthly insights.

## Project Structure
- **PDF Parsing**: Uses pypdf and PyPDF2 for PDF reading.
- **Data Manipulation**: Leverages pandas for data processing and categorization.
- **Excel Export**: Writes both detailed and aggregated data to Excel with pandas.

## Categorization:
Applies a dictionary-based categorization to group similar expenses.

## Excel Report Generation:
Saves both detailed and grouped data to an Excel sheet.
Displays category-wise total spending for easy tracking.

## Visualizations

- **Monthly Spending Over Time**: A line chart showing total spending each month.
- **Total Spending by Category**: A bar chart illustrating spending by category.
- **Monthly Category Distribution**: A pie chart detailing category-wise spending for a selected month (e.g., March 2024).

## Code Snippets
## PDF Parsing
```python
from pypdf import PdfReader

pdf_file_path = 'path_to_pdf.pdf'
reader = PdfReader(pdf_file_path)
selected_pages = [2, 3]

with open('log.txt', 'w') as log_file:
    for page_index in selected_pages:
        page = reader.pages[page_index]
        text = page.extract_text()
        if text:
            print(text, file=log_file)
```

## Filtering and Formatting
```python
import re

with open('log.txt', 'r') as f1, open('log1.txt', 'w') as f:
    trigger_line = "Purchases, Balance Transfers & Other Charges"
    search_pattern = r"^2877.*"
    
    for line in f1:
        if trigger_line in line:
            found_trigger = True
            continue

        if found_trigger and re.match(search_pattern, line):
            # Extract and format line data
            print(f"{line[34:-7].rstrip()}:{line[-7:].rstrip()}", file=f)
```

## Categorization
```python
patterns = {'KROGER': 'Grocery', 'AMAZON': 'Online Retail', 'MCDONALD': 'Outside Food', ...}

def classify_expense(expense):
    for pattern, category in patterns.items():
        if pattern in expense:
            return category
    return 'Other'

df['Category'] = df['expense'].apply(classify_expense)
```

## Excel Export
```python
with pd.ExcelWriter('output.xlsx') as writer:
    df.to_excel(writer, sheet_name='Sheet1', index=False)
    grouped_df = df.groupby('Category')['price'].sum().reset_index()
    grouped_df.to_excel(writer, sheet_name='Sheet1', index=False, startrow=len(df) + 5)
```

## Visualization
```python
# Filter data for a specific month (e.g., March 2024)
march_data = expenses_df[expenses_df['Month'] == '2024-03']
march_category_spending = march_data.groupby('Category')['Amount'].sum()

# Plot the pie chart
plt.figure(figsize=(7, 7))
plt.pie(march_category_spending, labels=march_category_spending.index, autopct='%1.1f%%', startangle=140, colors=sns.color_palette("viridis", len(march_category_spending)))
plt.title("Spending by Category for March 2024")
plt.show()
```

## Screenshots
