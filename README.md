# AccountLedger
This project demonstrates the implementation of a network layer and a simple UI using the [Erste Group Transparent Accounts API](https://developers.erstegroup.com/docs/apis/bank.csas/bank.csas.v3%2FtransparentAccounts). The API provides access to transparent accounts, including account details and transaction history.

<img src="https://github.com/kaffka-san/AccountLedger/blob/main/PreviewImages/video.gif?raw=true" width="350">

## Network Layer:

- Implements APICommunication for handling API requests and responses.
- Adds AccountsRouter to define endpoints for accounts and transactions.
- Centralizes error handling with NetworkingError.
- Implements APIManager protocol for abstracting network requests, enabling flexibility and testability.
- Added a service layer to handle API calls for fetching transactions and accounts.
- Implemented protocols (AccountsServiceProtocol) for better testability and abstraction.


## UI Implementation:
### List Screen:
<img src="https://github.com/kaffka-san/AccountLedger/blob/main/PreviewImages/list.png?raw=true" width="350">
 
 - Displays a list of all accounts, including their names and associated amounts.

### Detail Screen:
<img src="https://github.com/kaffka-san/AccountLedger/blob/main/PreviewImages/detail.png?raw=true" width="350">
 
 - Features a chart view to visualize monthly cash flow. 
 - Provides a detailed list of all transactions for the selected account.


## Future Improvements
📲 Dependency Injection: Add SwiftInject for better modularity and easier testing.

📑 Mock Data: Create mock responses for local development and previews.

✅ Unit Tests: Add tests for the network layer, view models, and data transformations.

📝 Linter: Use SwiftLint to enforce code style and maintain consistency.

🔓 Keychain Integration: Use Keychain to securely store sensitive data like API keys.

📦 UI Modularization: Refactor UI components for better reuse and scalability.
