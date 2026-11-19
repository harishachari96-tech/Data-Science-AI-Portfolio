import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error

# Step 1: Create a sample dataset (simulating a CSV file)
data = {
    'SquareFeet': [1400, 1600, 1700, 1200, 2000, 1500, 1450],
    'Bedrooms': [3, 3, 4, 2, 4, 3, 2],
    'Age': [10, 5, 2, 15, 1, 8, 12],
    'Price': [150000, 200000, 300000, 100000, 400000, 250000, 160000]
}

df = pd.DataFrame(data)

# Step 2: Split data into features (X) and target (y)
X = df[['SquareFeet', 'Bedrooms', 'Age']]
y = df['Price']

# Step 3: Train and Test Split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Step 4: Initialize and Train the Model
model = LinearRegression()
model.fit(X_train, y_train)

# Step 5: Evaluate the Model
predictions = model.predict(X_test)
mse = mean_squared_error(y_test, predictions)

print(f"Model Trained Successfully!")
print(f"Mean Squared Error on Test Data: {mse:.2f}")

# Step 6: Predict a new house price
new_house = pd.DataFrame([[1600, 3, 5]], columns=['SquareFeet', 'Bedrooms', 'Age'])
predicted_price = model.predict(new_house)
print(f"Predicted Price for 1500 sq ft, 3 beds, 5 years old: rs {predicted_price[0]:,.2f}")