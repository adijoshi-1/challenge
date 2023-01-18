<h1>Run the project</h1>
<h2>Ganache and Smart Contract</h2>

`ganache`

<ul>
    <li>Copy any private key</li>
    <li>Connect Metamask wallet to ganache rpc endpoint</li>
    <li>Import your private key in metamask wallet</li>
    <li>Go to remix ide</li>
    <li>Copy challenege.sol code and paste inside new file</li>
    <li>Compile the code and deploy it using metamask</li>
</ul>

<h2>Configuration to make</h2>

<ul>
    <li>Create a .env file in root directory of the project</li>
    <li>Create variables names RPC and WALLET_ADDRESS</li>
    <li>Populate that values with the actual values</li>
    <li>Update the contract address with the one we deployed in previous step inside contract.js file</li>
</ul>

<h2>Scripts to run</h2>

<h3>Install all the dependencies</h3>

`npm install`

<h3>To get the number of the contract</h3>

`npm run get`

<h3>To get the number of accounts that interacted with the contract</h3>

`npm run accounts`

<h3>To update the value with 99.1</h3>

`npm run update`

<h4>You can change the value to update in update_value.js file</h4>
