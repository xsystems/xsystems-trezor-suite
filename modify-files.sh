#!/bin/sh

if [ -n "${ORIGIN_HOSTNAME}" ] ; then
    sed -i "s@sldev\.cz@${ORIGIN_HOSTNAME}@g" /trezor-suite/packages/suite-data/files/connect/data/config.json
fi

if [ -n "${BLOCKBOOK_BITCOIN_URL}" ] ; then
    sed -i "s@https://btc.*\.trezor\.io@${BLOCKBOOK_BITCOIN_URL}@g" /trezor-suite/packages/blockchain-link/src/ui/config.ts
    sed -i "s@https://btc.*\.trezor\.io@${BLOCKBOOK_BITCOIN_URL}@g" /trezor-suite/packages/suite-data/files/connect/data/coins.json
    sed -i "s@https://btc.*\.trezor\.io@${BLOCKBOOK_BITCOIN_URL}@g" /trezor-suite/packages/suite/src/config/wallet/networks.ts
fi

if [ "${DISABLE_MONITORING}" = true ] ; then
    sed -i "s@!window.Cypress@false@g" /trezor-suite/packages/suite-web/pages/_app.tsx
fi

if [ "${DISABLE_ANALYTICS}" = true ] ; then
    sed -i "s@suite-analytics@onboarding-index@g" /trezor-suite/packages/suite/src/views/suite/welcome/index.tsx
    sed -i "s@!url@true@g" /trezor-suite/packages/suite/src/actions/suite/analyticsActions.ts
fi

if [ "${DISABLE_NEWS_FEED}" = true ] ; then
    sed -i "\@NewsFeed@d" /trezor-suite/packages/suite/src/views/dashboard/index.tsx
    sed -i "\@<SecurityFeatures />@{n;N;d}" /trezor-suite/packages/suite/src/views/dashboard/index.tsx
fi
