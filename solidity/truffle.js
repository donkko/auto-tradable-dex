
const HDWalletProvider = require('truffle-hdwallet-provider')
const address = '0x009e5048a61e062ca4939e5578Bd6a4Ad2425FF7'
const mnemonic = 'prewar geography atom qualifier safely excavate sandlot rancidity unusable threefold landlady scrabble'

module.exports = {
  networks: {
    development: {
      provider: new HDWalletProvider(mnemonic, 'https://ropsten.infura.io/'),
      host: 'localhost',
      port: 8545,
      network_id: '*',
      gas: 9000000,
      gasPrice: 10000000000
    }
  }
}
