// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * Horus Crypto (HORUS)
 * Clean fixed-supply ERC20 (BEP20-compatible on BSC)
 * - No privileged roles
 * - No mint (after deploy), burn, blacklist, taxes, limits, pause, or restrictions
 * - Single-file (easy to verify)
 */
contract HorusCrypto {
    // Token metadata
    string public constant name = "Horus Crypto";
    string public constant symbol = "HORUS";
    uint8 public constant decimals = 18;

    // Project links (on-chain, public)
    string public constant WEBSITE  = "https://horuscrypto.com";
    string public constant X_PROFILE = "https://x.com/HorusCryptoHQ";

    // Total supply: 250,000,000 * 10^18
    uint256 public constant totalSupply = 250_000_000 * 10**uint256(decimals);

    // --- Allocation wallets (EDIT THESE BEFORE DEPLOY) ---
    address public constant WALLET_LIQUIDITY         = 0x451E074E1843b3c3bCa13aD7FeC0c27293e3CB5c; // 10%  = 25,000,000
    address public constant WALLET_TREASURY          = 0x9be4b76ca2aE87848C97Ac204a0aDa9F1563D4b4; // 35%  = 87,500,000
    address public constant WALLET_DEPOSIT_GUARANTEE = 0xe8f3c4cC21A6fd4e00549d0D3a9ae386D93848e0; // 20%  = 50,000,000
    address public constant WALLET_MARKETING         = 0xAe6a22301FBe6429ce6aC8782691Ed2b63130C6B; // 15%  = 37,500,000
    address public constant WALLET_TEAM              = 0x9Db9B9Ed9A42e07360cdE063177A4dFb8DfFa155; // 10%  = 25,000,000
    address public constant WALLET_OPERATIONS        = 0x9e902c0c21C908f7A7e005D8f73D2B7251995E99; // 10%  = 25,000,000
    // -----------------------------------------------------

    mapping(address => uint256) private _balanceOf;
    mapping(address => mapping(address => uint256)) private _allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed from, address indexed spender, uint256 value);

    constructor() {
        require(WALLET_LIQUIDITY != address(0), "liquidity=0");
        require(WALLET_TREASURY != address(0), "treasury=0");
        require(WALLET_DEPOSIT_GUARANTEE != address(0), "guarantee=0");
        require(WALLET_MARKETING != address(0), "marketing=0");
        require(WALLET_TEAM != address(0), "team=0");
        require(WALLET_OPERATIONS != address(0), "operations=0");

        _mint(WALLET_LIQUIDITY,         25_000_000 * 10**uint256(decimals));
        _mint(WALLET_TREASURY,          87_500_000 * 10**uint256(decimals));
        _mint(WALLET_DEPOSIT_GUARANTEE, 50_000_000 * 10**uint256(decimals));
        _mint(WALLET_MARKETING,         37_500_000 * 10**uint256(decimals));
        _mint(WALLET_TEAM,              25_000_000 * 10**uint256(decimals));
        _mint(WALLET_OPERATIONS,        25_000_000 * 10**uint256(decimals));

        require(
            _balanceOf[WALLET_LIQUIDITY]
                + _balanceOf[WALLET_TREASURY]
                + _balanceOf[WALLET_DEPOSIT_GUARANTEE]
                + _balanceOf[WALLET_MARKETING]
                + _balanceOf[WALLET_TEAM]
                + _balanceOf[WALLET_OPERATIONS]
                == totalSupply,
            "supply mismatch"
        );
    }

    // Views
    function balanceOf(address account) external view returns (uint256) {
        return _balanceOf[account];
    }

    function allowance(address holder, address spender) external view returns (uint256) {
        return _allowance[holder][spender];
    }

    // Actions
    function transfer(address to, uint256 amount) external returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external returns (bool) {
        uint256 current = _allowance[from][msg.sender];
        require(current >= amount, "insufficient allowance");
        unchecked { _allowance[from][msg.sender] = current - amount; }
        _transfer(from, to, amount);
        return true;
    }

    function increaseAllowance(address spender, uint256 added) external returns (bool) {
        _approve(msg.sender, spender, _allowance[msg.sender][spender] + added);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtracted) external returns (bool) {
        uint256 current = _allowance[msg.sender][spender];
        require(current >= subtracted, "decrease > allowance");
        unchecked { _approve(msg.sender, spender, current - subtracted); }
        return true;
    }

    // Internals
    function _transfer(address from, address to, uint256 amount) internal {
        require(from != address(0), "from=0");
        require(to != address(0), "to=0");
        uint256 bal = _balanceOf[from];
        require(bal >= amount, "insufficient balance");
        unchecked {
            _balanceOf[from] = bal - amount;
            _balanceOf[to] += amount;
        }
        emit Transfer(from, to, amount);
    }

    function _approve(address from, address spender, uint256 amount) internal {
        require(from != address(0), "from=0");
        require(spender != address(0), "spender=0");
        _allowance[from][spender] = amount;
        emit Approval(from, spender, amount);
    }

    function _mint(address to, uint256 amount) internal {
        require(to != address(0), "mint to=0");
        _balanceOf[to] += amount;
        emit Transfer(address(0), to, amount);
    }
}
