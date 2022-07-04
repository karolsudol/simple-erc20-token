
# To deploy and verify our contract
forge script script/SimpleToken.s.sol:MyScSimpleTokenScriptript --rpc-url $RINKEBY_RPC_URL  --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv
