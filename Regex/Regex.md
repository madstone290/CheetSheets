# .NET 정규 표현식
참조
* [닷넷문서](https://learn.microsoft.com/en-us/dotnet/standard/base-types/regular-expression-language-quick-reference)

## Character Escapes

|패턴|설명|사용|일치|
|---|---|---|---|
| `\a` | Bell(알람). `\u0007`| `\a`  | `"\u0007"` in `"Error!"` + `"\u0007"` |
| `\b` | 백스페이스. `\u0008` | `[\b]{3,}` | `"\b\b\b\b"` in `"\b\b\b\b"` |
| `\t` | 탭. `\u0009`| `(\w+)\t` | `"item1\t"`, `"item2\t"` in `"item1\titem2\t"` |
| `\r` | 캐리지 리턴. `\u000D` | `\r\n(\w+)` | `"\r\nThese"` in `"\r\nThese are\ntwo lines."` |
| `\v` | 수직 탭. `\u000B` | `[\v]{2,}` | `"\v\v\v"` in `"\v\v\v"` |
| `\f` | 폼 피드. `\u000C` | `[\f]{2,}`	| `"\f\f\f"` in `"\f\f\f"` |
| `\n` | 뉴 라인. `\u000A` | `\r\n(\w+)` | `"\r\nThese"` in `"\r\nThese are\ntwo lines."` |
| `\e` | Esc. `\u001B` | `\e` | `"\x001B"` in `"\x001B"` |
| `\ nnn` | n은 8진수.  2,3 자리 사용. | `\w\040\w`	| `"a b"`, `"c d"` in `"a bc d"` |
| `\x nn` | n은 16진수. 2자리 사용 | `\w\x20\w` | `"a b"`, `"c d"` in `"a bc d"` |
| `\c X`, `\c x` | 컨트롤 + X or x 입력. | `\cC` | `"\x0003"` in `"\x0003"` (Ctrl-C) |
| `\u nnnn` | 유니코드 | `\w\u0020\w` | `"a b"`, `"c d"` in `"a bc d"` |

---

**NOTE**

\040 = \x20 = 32 = 스페이스

---

## Character Classes

|패턴|설명|사용|일치|
|---|---|---|---|
| `[문자열]` | 문자열에 포함된 문자 | `[ae]` | `"a"` in `"gray"` `"a"`, `"e"` in `"lane"` |
| `[^문자열]` | 문자열에 포함되지 않은 문자 | `[^aei]` | `"r"`, `"g"`, `"n"` in `"reign"` |
| `[시작문자-끝문자]` | 시작/끝 문자 및 사이에 포함된 문자 | `[A-Z]` | `"A"`, `"B"` in `"AB123"` |
| `.` | 와일드카드. `\n`을 제외한 모든 문자 | `a.e` | 	`"ave"` in `"nave"` `"ate"` in `"water"` |
| `\p{ name }` | 유니코드 카테고리/블록에 포함된 문자 | `\p{Lu}` `\p{IsCyrillic}` | `"C"`, `"L"` in `"City Lights"` `"Д"`, `"Ж"` in `"ДЖem"` |
| `\P{ name }` | 유니코드 카테고리/블록에 포함되지 않은 문자. `^\p{ name }` | `\p{Lu}` `\p{IsCyrillic}` | `"i"`, `"t"`, `"y"` in `"City"` `"e"`, `"m"` in `"ДЖem"` |
| `\w` | 워드 문자 | `\w` | `"I"`, `"D"`, `"A"`, `"1"`, `"3"` in `"ID A1.3"` |
| `\W` | 워드가 아닌 문자. `^\w` | `\W` | `" "`, `"."` in `"ID A1.3"` |
| `\s` | 공백 문자 | `\w\s` | `"D "` in `"ID A1.3"` |
| `\S` | 공백이 아닌 문자. `^\s` | `\s\S` |	`" _"` in `"int __ctr"` |
| `\d` | 숫자 문자 | `\d` | `"4"` in `"4 = IV"` |
| `\D` | 숫자가 아닌 문자.  `^\d` | `\D` | `" "`, `"="`, `" "`, `"I"`, `"V"` in `"4 = IV"`

---

**NOTE**
 
유니코드 카테고리
- Lu: 대문자
- IsCyrillic: 키릴 문자

---

## Anchors

|패턴|설명|사용|일치|
|---|---|---|---|
| `^` | 라인의 시작 | `^\d{3}` | `"901"` in `"901-333-"` |
| `$` | 라인의 끝 | `-\d{3}$` | `"-333"` in `"-901-333"` |
| `\A` | 문자열의 시작| `\A\d{3}` | `"901"` in `"901-333-"` |
| `\z` | 문자열의 끝| `-\d{3}\z` | `"-333"` in `"-901-333"` |
| `\Z` | 문자열의 끝 혹은 마지막 \n 앞 | `-\d{3}\Z` | `"-333"` in `"-901-333"` |
| `\G` | 이전 매치 위치. 이전 매치가 없는 경우 매치 시작 위치. | `\G\(\d\)` | `"(1)"`, `"(3)"`, `"(5)"` in `"(1)(3)(5)[7](9)"`
| `\b` | 단어 경계. \b단어\b 형태로 사용한다 | `\b\w+\s\w+\b` |	`"them theme"`, `"them them"` in `"them theme them them"` |
| `\B` | 단어 경계가 아님 | `\Bend\w*\b` | `"ends"`, `"ender"` in `"end sends endure lender"` |

## Grouping Constructs

|패턴|설명|사용|일치|
|---|---|---|---|
| `( subexpression )` | 표현식에 일치하는 값을 그룹에 담는다. 그룹번호는 1번부터 시작. | `(\w)\1` | `"ee"` in `"deep"` |
| `(?< name > subexpression )`or `(?' name ' subexpression )` | 표현식에 일치하는 값을 이름있는 그룹에 담는다 | `(?<double>\w)\k<double>` | `"ee"` in `"deep"` |
| `(?: subexpression ) ` | 캡처링을 수행하지 않는 그룹 | `(?:Line)?` | `"WriteLine"` in `"Console.WriteLine()"` `"Write"` in `"Console.Write(value)"` |
| `(?= subexpression )` | Zero-width positive lookahead assertion. | `\b\w+\b(?=.+and.+)` | `"cats"`, `"dogs"` in `"cats, dogs and some mice."` |
| `(?! subexpression )` | Zero-width negative lookahead assertion. | `\b\w+\b(?!.+and.+)` | `"and"`, `"some"`, `"mice"` in `"cats, dogs and some mice."` |
| `(?<= subexpression )` | Zero-width positive lookbehind assertion. | `b\w+\b(?<=.+and.+)`| `"some"`, `"mice"` in `"cats, dogs and some mice."` |
| - | - |  `\b\w+\b(?<=.+and.*)` | `"and"`, `"some"`, `"mice"` in `"cats, dogs and some mice."` |
| `(?<! subexpression )` | Zero-width negative lookbehind assertion. | `\b\w+\b(?<!.+and.+)` | `"cats"`, `"dogs"`, `"and"` in `"cats, dogs and some mice."` |
| - | - | `\b\w+\b(?<!.+and.*)` | `"cats"`, `"dogs"` in `"cats, dogs and some mice."` |
| `(?> subexpression )` | Atomic group. 매칭이 이루어지면 토큰정보를 버린다. | `(?>a\|ab)c` | `"ac"` in `"ac"` nothing in `"abc"` |

## Quantifiers

|패턴|설명|사용|일치|
|--|--|--|--|
| * | 0 이상. Greedy | `a.*c` | `"abcbc"` in `"abcbc"` |
| + | 1 이상. Greedy | `be+` | `"bee"` in `"been"`, `"be"` in `"bent"`
| ? | 0 혹은 1. Greedy | `rai?` | `"rai"` in `"rain"` |
| {n} | 정확히 n번. Greedy | `,\d{3}` |  `",043"` in `"1,043.6"`, `",876"`, `",543"`, and `",210"` in `"9,876,543,210"`
| {n,} | 최소 n 번. Greedy | `"\d{2,}"` | `"166"`, `"29"`, `"1930"` |
| {n,m} | n번에서 m번 사이. Greedy |  |  |
| *? | 0 이상. Lazy | `a.*?c` | `"abc"` in `"abcbc"` |
| +? | 1 이상. Lazy| `be+?` | `"be"` in `"been"`, `"be"` in `"bent"`
| ?? | 0 혹은 1. Lazy | `rai??` | `"ra"` in `"rain"` |
| {n}? | 정확히 n번. Lazy | `,\d{3}?` |  `",043"` in `"1,043.6"`, `",876"`, `",543"`, and `",210"` in `"9,876,543,210"`
| {n,}? | 최소 n 번. Lazy| `"\d{2,}?"` | `"166"`, `"29"`, `"1930"` |
| {n,m}? | n번에서 m번 사이. Lazy |  |  |

___
**NOTE**
- Greedy: 가능한 많이
- Lazy: 가능한 적게
___

## Backreference Constructs
|패턴|설명|사용|일치|
|--|--|--|--|
|`\n`| n은 0부터 시작하는 정수. \0은 루트그룹이며 모든 그룹이 포함된다. 일반적으로 \1 \2 등의 개별 그룹을 참조한다. | `(\w)\1` | "ee" in "seek" ||
|`\k<name>`| name은 그룹식별자.  (?\<name\>exp)의 그룹을 참조한다. | `(?<key1>\w)\k<key1>`