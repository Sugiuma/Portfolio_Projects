## Tool Rental System
The Tool Rental System is a Python-based application designed to facilitate the management of tool rentals for businesses. This project provides a straightforward interface to manage tool inventory, track customer rentals, and calculate rental costs, making it ideal for small rental businesses. It is built with a focus on functionality and ease of use.

## Features
- **Tool Inventory Management**: Keeps track of available tools, tool types, and rental statuses.
- **Customer Rental Tracking**: Allows users to rent tools by providing customer details and rental dates.
- **Dynamic Cost Calculation**: Calculates rental costs based on rental duration, applying daily rates for each tool type.
- **Rental History**: Maintains a history of rentals to facilitate tracking and ensure return deadlines are met.
- **Return Handling**: Updates tool availability when tools are returned, updating inventory status.

## Screenshots
### Initial Tool Inventory
![Initial Tool Inventory](assets/images/initial_prompt.png)

### Rental Entry and Cost Calculation
![Rental Entry and Cost Calculation](assets/images/problem_display.png)

### Rental History and Return Handling
![Rental History and Return Handling](assets/images/final_score.png)


## Code Structure
- **ToolRentalSystem**: The main class for the application, handling tool inventory, rental management, and cost calculation.
- **Inventory Management**: Adds tools to the inventory and tracks their availability status.
- **Rental Processing**: Records customer rentals, calculates rental fees based on duration, and updates tool status.
- **Cost Calculation and Rental History**: Tracks total cost for each rental and maintains a log of all transactions for easy access.


## Code Snippets
## Initialization and Main Functionalities

class ToolRentalSystem:
    def __init__(self):
        self.inventory = {}
        self.rental_history = []
    
    def add_tool(self, tool_name, tool_type, daily_rate):
        self.inventory[tool_name] = {
            "type": tool_type,
            "daily_rate": daily_rate,
            "is_available": True
        }
    
    def rent_tool(self, tool_name, customer_name, rental_days):
        if tool_name in self.inventory and self.inventory[tool_name]["is_available"]:
            rental_cost = self.inventory[tool_name]["daily_rate"] * rental_days
            self.rental_history.append((tool_name, customer_name, rental_days, rental_cost))
            self.inventory[tool_name]["is_available"] = False
            return rental_cost
        return "Tool not available."
    
    def return_tool(self, tool_name):
        if tool_name in self.inventory:
            self.inventory[tool_name]["is_available"] = True
