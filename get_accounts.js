/* eslint-disable no-undef */

require('dotenv').config()
const Web3 = require('web3')
const { abi, address } = require('./contract')
const rpc = process.env.RPC

const web3 = new Web3(rpc)
const Contract = new web3.eth.Contract(abi, address)

const get_accounts = async () => {
  try {
    const accounts = await Contract.methods.getUserCount().call()
    console.log('Accounts Count: ', accounts)
  } catch (err) {
    console.log(err)
  }
}

get_accounts()
