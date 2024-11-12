## Family Routine Tracker
The Family Routine Tracker is a Python-based GUI application that enables family members to log and monitor their daily activities in a structured, personalized manner. Built using Tkinter, Excel, and Matplotlib, this application is designed to track activities, display logs, and generate monthly visual reports.

## Features
- **Personalized Activity Tracking**: Each family member has a unique set of activities, selectable by name from a dropdown menu. Activities and their durations are saved to separate Excel sheets per family member within a single workbook.
- **Data Persistence and Storage**: Logs are stored in an Excel file (routine_tracker.xlsx) and updated per family member for easy access and review.
- **Dynamic Data Display**: Daily logs are viewable in the app, with automatic updates based on the selected family member and date.
- **Monthly Reporting with Visualizations**: Generates monthly bar and pie charts to visualize time spent on each activity, providing insights into trends and time allocation.


## Key Features
- **Data Input**:
Data is stored in a CSV file with columns for Date, Activity, and Duration.
Activities are defined per family member with a dictionary structure, giving each member a personalized set of activities.
- **Activity Tracking**:
Records each family member’s daily activities and duration (in minutes).
Sets daily target times for each activity (e.g., Reading = 20 minutes, Exercise = 30 minutes).
- **Monthly Report Generation**:
Filters activities for the current month per family member.
Calculates total time spent on each activity, comparing it to the monthly target duration.
Generates pie charts showing completion percentages (target time achieved) for each activity.
- **Visualization**:
Side-by-side pie charts are created for each activity, offering clear visual comparisons.
A green indicator marks activities that achieve 75% or more of the target, making it easy to see which goals were met.
- **Output**:
Saves all activity reports into a single PDF file, with one page per family member, displaying pie charts for their respective activities.
The PDF filename is dynamically generated based on the current month’s name.

## Technologies Used
- **Python**: For data processing and report generation.
- **Pandas**: For data handling and manipulation.
- **Matplotlib**: For creating visual charts.
- **PdfPages from Matplotlib**: For exporting multiple plots into a single PDF document.


## Future Enhancements
Adding additional report types (e.g., bar charts, time series analysis).
Automating email generation to send reports to each family member.

## License
This project is open-source and available under the MIT License.

## Code Snippets
## Initializing Data Storage in Excel
This code checks if the routine_tracker.xlsx file exists. If not, it creates it with a separate sheet for each family member.

```python
import pandas as pd
import os

family_members = ["Prathiksha", "Suganya", "Socrates"]

if not os.path.exists("routine_tracker.xlsx"):
    with pd.ExcelWriter("routine_tracker.xlsx") as writer:
        for member in family_members:
            pd.DataFrame(columns=["Date", "Activity", "Duration"]).to_excel(writer, sheet_name=member, index=False)
```

## Saving Activity Records
The save_activities function saves activity data to the corresponding sheet for the selected family member. It displays a success message upon successful save and updates the activity log display.

```python
import tkinter as tk
from tkinter import ttk

def save_activities():
    selected_member = member_dropdown.get()
    date = date_entry.get()
    records = [[date, activity, duration_entry.get()] for activity, duration_entry in activity_entries if duration_entry.get()]

    if records:
        df_new = pd.DataFrame(records, columns=["Date", "Activity", "Duration"]).astype({"Duration": int})
        with pd.ExcelWriter("routine_tracker.xlsx", mode="a", engine="openpyxl", if_sheet_exists="replace") as writer:
            df_member = pd.read_excel(writer, sheet_name=selected_member)
            pd.concat([df_member, df_new], ignore_index=True).to_excel(writer, sheet_name=selected_member, index=False)
        message.set("Activities recorded successfully!")
        update_display(date)
        for _, entry in activity_entries:
            entry.delete(0, tk.END)
    else:
        message.set("Please enter duration for at least one activity.")
```

## Updating Display for Selected Date
This function reads the Excel file and updates the table display to show recorded activities for a specific date.

```python
def update_display(date):
    selected_member = member_dropdown.get()
    for row in table.get_children():
        table.delete(row)

    df_member = pd.read_excel("routine_tracker.xlsx", sheet_name=selected_member)
    specific_date_data = df_member[df_member["Date"] == date]
    
    if not specific_date_data.empty:
        for _, row in specific_date_data.iterrows():
            table.insert("", "end", values=(row["Date"], row["Activity"], row["Duration"]))
    else:
        message.set("No activities recorded for this date.")
```

## Generating Monthly Bar Chart Report
The generate_monthly_bar_report function aggregates activity durations for the current month and displays them in a bar chart.

```python
import matplotlib.pyplot as plt
from datetime import datetime

def generate_monthly_bar_report():
    selected_member = member_dropdown.get()
    df_member = pd.read_excel("routine_tracker.xlsx", sheet_name=selected_member)
    
    current_month = datetime.now().strftime("%Y-%m")
    df_month = df_member[pd.to_datetime(df_member["Date"]).dt.strftime("%Y-%m") == current_month]
    activity_durations = df_month.astype({"Duration": int}).groupby("Activity")["Duration"].sum()

    plt.figure(figsize=(10, 5))
    activity_durations.plot(kind="bar", color="skyblue")
    plt.title(f"Activity Report for {selected_member} - {current_month}")
    plt.xlabel("Activities")
    plt.ylabel("Total Duration (minutes)")
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.show()
```

## Updating Activity Entry Fields
This snippet dynamically updates the list of activity entry fields in the GUI based on the selected family member.

```python
def update_activity_entries(*args):
    for widget in activity_frame.winfo_children():
        widget.destroy()

    selected_member = member_dropdown.get()
    activities = activities_dict.get(selected_member, [])

    global activity_entries
    activity_entries = []
    for activity in activities:
        tk.Label(activity_frame, text=f"{activity} Duration (minutes):", anchor="w").pack(fill="x")
        duration_entry = tk.Entry(activity_frame, width=20)
        duration_entry.pack(fill="x")
        activity_entries.append((activity, duration_entry))
```

### Screenshots
