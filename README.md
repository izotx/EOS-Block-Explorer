# EOS Block Explorer

User Story:
========
```
As an EOS User I want to see the contents of the most recent blocks on the public
blockchain.

```

Developer Notes
=========
- There are two apps in the repositiory:
#### App 1 EOS BlockExplorer: Main task
 ##### Features
- Blockchain related operations can be found in the Blockchain.swift file 
- Unit tests that cover mostly JSON parsing can be found in: EOSBlockExplorerTests.swift
- Doesn't use external libraries
 ##### Improvements
 Given more time I would implement several things differently:
1. I would chain networking operations using RxSwift or PromiseKit
2. Core Data and fetch view controller for displaying blocks 
3. Sync with blockchain beyond 20 first blocks

#### App 2 Ricardian App: Bonus task
You can find the app in RicardianApp. 
 ##### Features
- reading and displaying Ricardian contracts based on specified transaction id
- no markup. I ran out of time
- New York block producer's api doesn't respond correctly to get transaction. I had to use one in Asia: https://api1.eosasia.one
- use of external libraries like SwiftyJson, AlamoFire, PromiseKit



App Preview
========
![app preview](https://thumbs.gfycat.com/BewitchedBlackandwhiteIbadanmalimbe-size_restricted.gif "App Preview")



Resources:
========
-  EOS: https://github.com/EOSIO/eos
-  Public Node endpoint: https://api.eosnewyork.io/v1
-  Utilize RPC endpoints to get necessary data
-  RPC Endpoint Documentation (block contents may vary): https://developers.eos.io/eosio-nodeos/reference

Acceptance Criteria:
========
- [x] App has a button which when clicked will display a list of the 20 most recent blocks
- [x] When user clicks on a block they should be taken to a Block Details Screen.
- [x] The Details screen should show a summary view with of the block which contains the
producer, count of transactions and the producer signature.
- [x] The Details screen should have a toggle to show and hide the raw contents of the
transaction.
- [x] Application Code viewable Publicly on Github
- [x] Screenshots of working application should be in the github Readme
- [x] Application should be written in Swift4
- [x] Application should have unit tests

Bonus Criteria:
- [] Render the (markdown) ricardian contracts included in the abi with the relevant data
from the action. Example implementation in Javascript available here for reference:
https://codepen.io/chris-allnutt/pen/ERXwjb


Screenshots
========
<p align="center">
<img src="Screenshots/sim1.png" width="30%" align="left" />
<img src="Screenshots/sim2.png" width="30%" align="left" />
<img src="Screenshots/sim3.png" width="30%" align="left" />
<img src="Screenshots/sim4.png" width="30%" align="left" />
<img src="Screenshots/sim5.png" width="30%" align="left" />
<img src="Screenshots/sim6.png" width="30%" align="left" />
<img src="Screenshots/sim7.png" width="30%" align="left" />
</p>



