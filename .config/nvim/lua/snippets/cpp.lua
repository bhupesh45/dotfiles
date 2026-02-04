local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	-- 1. Full CP Template
	-- Trigger: type 'cp' and hit Tab
	s(
		"cp",
		fmt(
			[[
        #include <bits/stdc++.h>
        using namespace std;

        #define fastio ios_base::sync_with_stdio(false); cin.tie(NULL);
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

	-- 2. Fast "all" macro
	-- Trigger: type 'all' -> expands to 'v.begin(), v.end()'
	s(
		"all",
		fmt("{}.begin(), {}.end()", {
			i(1, "v"),
		})
	),

	-- 3. Simple integer loop
	-- Trigger: type 'lp' -> expands to 'for(int i = 0; i < n; ++i)'
	s(
		"lp",
		fmt("for(int {} = 0; {} < {}; ++{}) {{\n\t{}\n}}", {
			i(1, "i"),
			i(2, "i"), -- This node mirrors node 1 if you want, or keeps it manual
			i(3, "n"),
			i(4, "i"),
			i(0),
		})
	),

	-- 4. Vector Input
	-- Trigger: type 'vin' -> reads n elements into vector v
	s(
		"vin",
		fmt(
			[[
        int n; cin >> n;
        vector<int> {}(n);
        for(int i=0; i<n; ++i) cin >> {}[i];
    ]],
			{
				i(1, "v"),
				i(2, "v"), -- You can also use rep(1) here to auto-copy the vector name
			}
		)
	),
}
