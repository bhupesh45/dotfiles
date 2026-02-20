local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep -- <--- CRITICAL IMPORT

return {
	-- 1. Full CP Template
	s(
		"cp",
		fmt(
			[[
        #include <bits/stdc++.h>
        using namespace std;

        #define fastio
            ios_base::sync_with_stdio(false);
            cin.tie(NULL);
        #define ll long long
        #define all(x) (x).begin(), (x).end()

        void solve() {{
            {}
        }}

        int main() {{
            fastio;
            int t; 
            cin >> t;
            while(t--) {{
                solve();
            }}
            return 0;
        }}
    ]],
			{
				i(1, "// Your code here"),
			}
		)
	),

	-- 2. Fast "all" macro (FIXED)
	-- Trigger: type 'all' -> expands to 'v.begin(), v.end()'
	-- If you change 'v' to 'arr', the second part updates automatically.
	s(
		"all",
		fmt("{}.begin(), {}.end()", {
			i(1, "v"),
			rep(1),
		})
	),

	-- 3. Simple integer loop (IMPROVED)
	-- Trigger: type 'lp' -> expands to 'for(int i = 0; i < n; ++i)'
	-- We use rep(1) so you only type 'i' once, and it updates everywhere.
	s(
		"lp",
		fmt("for(int {} = 0; {} < {}; ++{}) {{\n\t{}\n}}", {
			i(1, "i"),
			rep(1), -- Automatically repeats 'i'
			i(2, "n"),
			rep(1), -- Automatically repeats 'i'
			i(0),
		})
	),

	-- 4. Vector Input (IMPROVED)
	-- Trigger: type 'vin' -> reads n elements into vector v
	s(
		"vin",
		fmt(
			[[
        int {}; cin >> {};
        vector<int> {}({});
        for(int i=0; i<{}; ++i) cin >> {}[i];
    ]],
			{
				i(1, "n"), -- variable for size
				rep(1), -- repeat size
				i(2, "v"), -- variable for vector
				rep(1), -- repeat size
				rep(1), -- repeat size (loop limit)
				rep(2), -- repeat vector name
			}
		)
	),
}
