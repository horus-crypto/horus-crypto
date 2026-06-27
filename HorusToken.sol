// SPDX-License-Identifier: MIT
pragma solidity ^0.8.35;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title HORUS
 * @notice Fixed-supply BEP-20 compatible token for BNB Smart Chain.
 *
 * Token details:
 * - Name: HORUS
 * - Symbol: HORUS
 * - Decimals: 18
 * - Total Supply: 1,000,000,000 HORUS
 *
 * Design:
 * - Fixed supply
 * - No owner
 * - No external mint function
 * - No burn function
 * - No pause function
 * - No blacklist
 * - No whitelist
 * - No taxes
 * - No transaction limits
 * - No wallet limits
 * - No cooldown
 * - No anti-bot logic
 * - No trading restrictions
 * - No proxy
 * - No upgradeability
 * - No privileged functions after deployment
 */
contract HORUS is ERC20 {

    uint8 public constant TOKEN_DECIMALS = 18;
    uint256 private constant TOKEN_UNIT = 1e18;

    uint256 public constant TOTAL_SUPPLY = 1_000_000_000 * TOKEN_UNIT;

  address public constant LIQUIDITY_WALLET =
    0x1Dd89353a0bF930C2015154f12D256b9DD80027e;

address public constant COMMUNITY_REWARDS_WALLET =
    0xe791839b44Ae192e63adf26Ada85c342dc0e3392;

address public constant ECOSYSTEM_GROWTH_WALLET =
    0xE728Fc37B2FCC194860eA0C188f0225B363220fD;

address public constant FOUNDATION_TREASURY_WALLET =
    0x876790b117Fcb71871d10F687828CC721180d6A8;

address public constant RESEARCH_AND_DEVELOPMENT_WALLET =
    0x2E4a908f78241AAb16c9D9CE26064d019AcB893b;

address public constant MARKETING_AND_PARTNERSHIPS_WALLET =
    0x16c1b102237Bad2a8df743206A65E9054b860fb7;

address public constant STRATEGIC_RESERVE_WALLET =
    0x982D3E588CE56Cc2c13a542BB2a133EA80227991;

address public constant TEAM_WALLET =
    0x04Fd51FECe9f8D45cfcFAdF3B925069317c474B9;

    constructor() ERC20("HORUS", "HORUS") {
        _mint(LIQUIDITY_WALLET, 100_000_000 * TOKEN_UNIT);
        _mint(COMMUNITY_REWARDS_WALLET, 200_000_000 * TOKEN_UNIT);
        _mint(ECOSYSTEM_GROWTH_WALLET, 200_000_000 * TOKEN_UNIT);
        _mint(FOUNDATION_TREASURY_WALLET, 220_000_000 * TOKEN_UNIT);
        _mint(RESEARCH_AND_DEVELOPMENT_WALLET, 100_000_000 * TOKEN_UNIT);
        _mint(MARKETING_AND_PARTNERSHIPS_WALLET, 100_000_000 * TOKEN_UNIT);
        _mint(STRATEGIC_RESERVE_WALLET, 50_000_000 * TOKEN_UNIT);
        _mint(TEAM_WALLET, 30_000_000 * TOKEN_UNIT);

        assert(totalSupply() == TOTAL_SUPPLY);
    }

    function decimals() public pure override returns (uint8) {
        return TOKEN_DECIMALS;
    }

    function getOwner() external pure returns (address) {
        return address(0);
    }
}
