/* eslint-disable no-undef */

require('dotenv').config()
const Web3 = require('web3')
const { abi, address } = require('./contract')
const rpc = process.env.RPC

const web3 = new Web3(rpc)
const Contract = new web3.eth.Contract(abi, address)

const get_value = async () => {
  try {
    const decimals = parseInt(await Contract.methods.getDecimals().call())
    const value = parseInt(await Contract.methods.getNumber().call())
    const actualValue = value / 10 ** decimals
    console.log('Value', actualValue)
  } catch (err) {
    console.log(err)
  }
}

get_value()
