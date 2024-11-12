Tool Rental System
A Python-based tool rental system that enables customers to rent tools on an hourly, daily, or weekly basis, manage inventory, and calculate rental fees. Built with object-oriented programming principles, this project includes features for tracking rentals, handling returns, and calculating bills based on rental duration.

Table of Contents
Features
Project Structure
Classes and Methods
Getting Started
Usage
Code Snippets
Example
License
Features
Display Inventory: Shows available tools and quantities in stock.
Rental Options: Allows customers to rent tools on an hourly, daily, or weekly basis.
Return and Billing: Calculates rental cost based on tool type, quantity, and rental duration.
Error Handling: Validates rental requests, ensuring enough stock and valid rental basis inputs.
Project Structure
The project is organized into three main classes in rental_oop.py:

Rental: A base class for managing tool stock.
ToolRental: Inherits from Rental, handles tool rental operations (hourly, daily, weekly).
Customer: Manages customer interactions and rental requests.
File Structure
plaintext
Copy code
.
├── rental_oop.py      # Contains the Rental, ToolRental, and Customer classes
├── main.py            # Main script to run the tool rental system
├── README.md          # Project documentation
└── tests.py           # Unit tests for the classes and methods
Classes and Methods
Rental Class
Manages tool stock display.
display_stock: Shows available tools and quantities in stock.
ToolRental Class
Handles rental operations (hourly, daily, weekly) and billing.
rent_tool(tool, n, basis): Rents a specified quantity of tools on the chosen basis (hourly, daily, weekly).
return_tool(tool, rental_time, rental_basis, n): Calculates the bill based on rental duration and replenishes stock.
Customer Class
Manages customer actions.
request_tool: Gathers rental tool type and quantity from the customer.
choose_rental_basis: Allows the customer to choose the rental basis.
return_tool: Facilitates the return process.
Getting Started
Clone the Repository
bash
Copy code
git clone https://github.com/yourusername/tool-rental-system.git
cd tool-rental-system
Run the Main Application
bash
Copy code
python main.py
Run Unit Tests
bash
Copy code
python -m unittest tests.py
Usage
When you run main.py, the system provides options for displaying stock, renting tools, returning tools, and exiting.

plaintext
Copy code
====== Tool Rental Shop =======
1. Display available tools
2. Rent a tool on an hourly basis
3. Rent a tool on a daily basis
4. Rent a tool on a weekly basis
5. Return a tool
6. Exit
Code Snippets
Displaying Available Stock
python
Copy code
shop = ToolRental({
    "sander": 10,
    "drill": 15,
    "circular saw": 5
})
shop.display_stock()
# Output:
# We have 10 sander(s) available to rent.
# We have 15 drill(s) available to rent.
# We have 5 circular saw(s) available to rent.
Renting a Tool
python
Copy code
rental_time = shop.rent_tool("drill", 2, "hourly")
# Output:
# You have rented 2 drill(s) on an hourly basis at 14 hours.
# You will be charged $4 per hour per tool.
Returning a Tool
python
Copy code
# Assuming the rental was made one hour ago
bill = shop.return_tool("drill", rental_time, "hourly", 2)
print(f"Total bill: ${bill:.2f}")
# Output: Total bill: $8.00
Example
Here’s a sample interaction for renting and returning tools in the system:

python
Copy code
# Initialize inventory and customer
shop = ToolRental({
    "sander": 10,
    "drill": 15,
    "circular saw": 5
})
customer = Customer()

# Customer rents 2 drills on an hourly basis
customer.tool, customer.tools = "drill", 2
customer.rental_basis = "hourly"
customer.rental_time = shop.rent_tool("drill", 2, "hourly")

# Customer returns the tools after some time
bill = shop.return_tool("drill", customer.rental_time, customer.rental_basis, 2)
print(f"Total bill for returning tools: ${bill:.2f}")
License
This project is open-source and available under the MIT License.
