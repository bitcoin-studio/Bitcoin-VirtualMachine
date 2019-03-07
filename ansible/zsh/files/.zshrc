source /home/bitcoin/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply

###
# Aliases
alias addalias='nano /home/bitcoin/.zshrc'

alias btccli='bitcoin-cli'
alias btcclin='bitcoin-cli -named'
alias btclistunspent="bitcoin-cli listunspent | jq -r '.[] | { txid: .txid, vout: .vout, amount: .amount }'"

alias btcd­start="systemctl start btcd.service"
alias btcd­stop="systemctl stop btcd.service"
alias btcd­restart="systemctl restart btcd.service"
alias btcd­status="systemctl status btcd.service"
alias btcd­log="journalctl ­u btcd"

alias lnclit='lncli --network=testnet'
alias lnclir='lncli --network=regtest'
alias lnclis='lncli --network=simnet'

alias lnd­start="systemctl start lnd.service"
alias lnd­stop="systemctl stop lnd.service"
alias lnd­restart="systemctl restart lnd.service"
alias lnd­status="systemctl status lnd.service"
alias lnd­update="~/lnd­update"
alias lncliweb­start="systemctl start lncliweb.service"
alias lncliweb­stop="systemctl stop lncliweb.service"
alias lncliweb­restart="systemctl restart lncliweb.service"
alias lncliweb­status="systemctl status lncliweb.service"
alias lncliweb­update="~/lncliweb­update"

alias btcconf='nano /home/bitcoin/.bitcoin/bitcoin.conf'
alias lndconf='nano /home/bitcoin/.lnd/lnd.conf'

alias btcdebug='tail /home/bitcoin/.bitcoin/testnet3/debug.log -f'
alias btcdebugf='tail /home/bitcoin/.bitcoin/testnet3/debug.log -f'
alias btcdebugn='tail /home/bitcoin/.bitcoin/testnet3/debug.log -n 200'

alias lnddebug='tail /home/bitcoin/.lnd/logs/bitcoin/testnet/lnd.log -f'
alias lnddebugf='tail /home/bitcoin/.lnd/logs/bitcoin/testnet/lnd.log -f'
alias lnddebugn='tail /home/bitcoin/.lnd/logs/bitcoin/testnet/lnd.log -n 200'

alias nodestatus='systemctl status bitcoind lnd tor'

alias torconf='sudo nano /etc/tor/torrc'
alias tordebug='sudo tail /var/log/tor/notices.log -f'
alias tordebug2='sudo tail /var/log/tor/debug.log -f'