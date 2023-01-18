/* eslint-disable no-unused-vars */
/* eslint-disable no-undef */

require('dotenv').config()
const Web3 = require('web3')
const { abi, address } = require('./contract')
const rpc = process.env.RPC
const wallet_address = process.env.WALLET_ADDRESS

const web3 = new Web3(rpc)
const Contract = new web3.eth.Contract(abi, address)

const interact = async () => {
  try {
    const decimals = parseInt(await Contract.methods.getDecimals().call())
    const value = 10
    const actualValue = BigInt(value * 10 ** decimals).toString()
    await Contract.methods.updateValue(actualValue).send({
      from: wallet_address,
    })
    console.log('Smart Contract Updated')
  } catch (err) {
    console.log(err.message)
  }
}

interact()
