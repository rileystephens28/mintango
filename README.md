<div id="top"></div>

<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![MIT License][license-shield]][license-url]
![top-languages-shield]
![languages-count-shield]
![status-shield]
<!-- PROJECT LOGO -->
<br />
<div align="center">
  <!-- <a href="https://github.com/rileystephens28/mintango">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a> -->
  <h2 align="center">Mintango</h2>
  <p align="center">
    <i>ERC-1155 NFT Minting Dapp</i>
    <br />
    <br />
    <a href="https://github.com/rileystephens28/mintango/issues">Report Bug</a>
    ·
    <a href="https://github.com/rileystephens28/mintango/issues?q=is%3Aopen+is%3Aissue+label%3Aenhancement">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
        <a href="#about-the-project">About Mintango</a>
        <ul><a href="#features">Features</a></ul>
        <ul><a href="#built-with">Built With</a></ul>
    </li>
    <li>
        <a href="#getting-started">Getting Started</a>
        <ul><a href="#prerequisites">Prerequisites</a></ul>
        <ul><a href="#installation">Installation</a></ul>
    </li>
     <li>
        <a href="#usage">Usage</a>
        <ul><a href="#erc-1155-contract">ERC-1155 Contract</a></ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>
<br />

<!-- ABOUT THE PROJECT -->
## About Mintango

Mintango is a fun and simple dapp that allows you to mint custom ERC-1155 NFTs that contain a name, description, and image. Once you have minted your new token you can check them out in the "My Goods" section of the dapp.

### Features

* Mint custom ERC-1155 NFTs
* Stores token metadata on IPFS
* Minting fee (this will be controled by a DAO)
* On-chain token up/down voting (an account can vote on a certain token once)
* Backlisting Ethereum accounts to prevent them from minting and voting
* Whitelisting Ethereum accounts to exempt them from paying the minting fee

### Built With

* [React.js][react] v17.0.2+
* [Tuffle ][truffle]
* [Moralis ][moralis]

<!-- ROADMAP -->
## Roadmap

- [x] Custom ERC-1155 minting
- [x] IPFS metadata storage
- [x] Minting fee
- [x] Account blacklisting
- [x] Account whitelisting
- [x] On-chain up/down voting
- [ ] Minting fee payouts to DAO
- [ ] Minting fee changes from DAO
- [ ] Max token supply changes from DAO
- [ ] Batch mint token collections
- [ ] List NFTs on Opensea


See the [open issues][github-issues] for a full list of proposed features (and known issues).

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch
   ```sh
   git checkout -b feature/AmazingFeature
   ```
3. Commit your Changes 
    ```sh
    git commit -m 'Add some AmazingFeature'
    ```
4. Push to the Branch 
   ```sh
    git push origin feature/AmazingFeature
    ```
6. Open a Pull Request


<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<!-- CONTACT -->
## Contact

Riley Stephens - rileystephens@escalatorllc.com

<p align="right"><a href="#top">back to top</a></p>



<!-- Project URLS-->
[github-url]: https://github.com/rileystephens28/mintango
[github-issues]: https://github.com/rileystephens28/mintango/issues
[repo-path]: rileystephens28/mintango

<!-- Built With URLS -->
[react]: https://reactjs.org/
[truffle]: https://trufflesuite.com/
[moralis]: https://moralis.io/


<!-- License Badge -->
[license-shield]: https://img.shields.io/github/license/rileystephens28/mintango.svg?style=for-the-badge
[license-url]: https://github.com/rileystephens28/mintango/blob/main/LICENSE.txt

<!-- Version Badge -->
[package-version-shield]: https://img.shields.io/github/package-json/v/rileystephens28/mintango.svg?style=for-the-badge

<!-- Build Status Badge -->
[build-status-shield]: https://img.shields.io/travis/com/rileystephens28/mintango.svg?style=for-the-badge

<!-- Contributors Badge -->
[contributors-shield]: https://img.shields.io/github/contributors/rileystephens28/mintango.svg?style=for-the-badge
[contributors-url]: https://github.com/rileystephens28/mintango/graphs/contributors

<!-- Languages Badge-->
[top-languages-shield]: https://img.shields.io/github/languages/top/rileystephens28/mintango.svg?style=for-the-badge

[languages-count-shield]: https://img.shields.io/github/languages/count/rileystephens28/mintango.svg?style=for-the-badge

[status-shield]: https://img.shields.io/static/v1?label=status&message=under%20construction&color=red&style=for-the-badge