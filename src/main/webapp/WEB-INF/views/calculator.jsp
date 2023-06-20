<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="style.css" />
    <title>Calculator</title>
  </head>
  <body>
    <main
      class="w-full flex h-screen justify-center items-center bg-[url('https://4kwallpapers.com/images/walls/thumbs_3t/8133.jpg')] bg-cover bg-no-repeat bg-center">
      <div class="w-full relative max-w-[20rem] mx-auto">
        <div
          class="text-white relative backdrop-blur-3xl bg-[#2e2725]/40 rounded-2xl overflow-hidden border border-white/50 border-[1px]">
          <form method="post" action="calculate">
            <div class="pt-4 bg-[#2e2725]/40">
              <input
                disabled
                class="result textfit bg-transparent w-full text-right pr-4 p-4 text-white text-5xl"
                name="expression"
                id="expression"
                value="0" />
            </div>
            <div class="grid grid-cols-4 z-10 gap-x-[1px] gap-y-[1px]">
              <button
                class="p-4 text-[26px] active:bg-white/50 bg-[#433c3a]/20 text-center"
                type="button"
                onclick="clearExpression()">
                AC
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/50 bg-[#433c3a]/20 text-center"
                type="button"
                onclick="toggleSign()">
                <sup class="-mr-1">+</sup>
                &#x2044;-
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/50 bg-[#433c3a]/20 text-center"
                type="button"
                onclick="appendToExpression('%')">
                %
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/80 bg-[#ff9f0b] text-center"
                type="button"
                onclick="appendToExpression('/')">
                &#xF7;
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/50 bg-[#625c5b]/50 text-center"
                type="button"
                onclick="appendToExpression('7')">
                7
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/50 bg-[#625c5b]/50 text-center"
                type="button"
                onclick="appendToExpression('8')">
                8
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/50 bg-[#625c5b]/50 text-center"
                type="button"
                onclick="appendToExpression('9')">
                9
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/80 bg-[#ff9f0b] text-center"
                type="button"
                onclick="appendToExpression('x')">
                x
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/50 bg-[#625c5b]/50 text-center"
                onclick="appendToExpression('4')"
                type="button">
                4
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/50 bg-[#625c5b]/50 text-center"
                onclick="appendToExpression('5')"
                type="button">
                5
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/50 bg-[#625c5b]/50 text-center"
                onclick="appendToExpression('6')"
                type="button">
                6
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/80 bg-[#ff9f0b] text-center"
                type="button"
                onclick="appendToExpression('-')">
                -
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/50 bg-[#625c5b]/50 text-center"
                type="button"
                onclick="appendToExpression('1')">
                1
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/50 bg-[#625c5b]/50 text-center"
                type="button"
                onclick="appendToExpression('2')">
                2
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/50 bg-[#625c5b]/50 text-center"
                type="button"
                onclick="appendToExpression('3')">
                3
              </button>

              <button
                class="p-4 text-[26px] active:bg-white/80 bg-[#ff9f0b] text-center"
                type="button"
                onclick="appendToExpression('+')">
                +
              </button>
              <button
                class="p-4 text-[26px] active:bg-white/50 col-span-2 bg-[#625c5b]/50 text-center"
                type="button"
                onclick="appendToExpression('0')">
                0
              </button>
              <button
                class="p-4 text-[26px] active:bg-white/50 bg-[#625c5b]/50 text-center"
                type="button"
                onclick="appendToExpression('.')">
                .
              </button>
              <input
                class="p-4 cursor-pointer text-[26px] active:bg-white/80 bg-[#ff9f0b] text-center"
                type="button"
                value="="
                onclick="calculateExpression()" />
            </div>
          </form>
        </div>
      </div>
    </main>
  </body>

  <script>
    function appendToExpression(value) {
      if (document.getElementById("expression").value === "0") {
        document.getElementById("expression").value = value;
      } else {
        var expression = document.getElementById("expression").value;
        if (value === "%") {
          // If percentage sign is clicked, evaluate the expression and divide by 100
          var result = eval(expression) / 100;
          document.getElementById("expression").value = result;
        } else {
          document.getElementById("expression").value += value;
        }
      }
    }

    function clearExpression() {
      document.getElementById("expression").value = "0";
    }

    function toggleSign() {
      var expression = document.getElementById("expression").value;
      if (expression.startsWith("-")) {
        expression = expression.substring(1);
      } else {
        expression = "-" + expression;
      }
      document.getElementById("expression").value = expression;
    }

    function calculateExpression() {
      var expression = document.getElementById("expression").value;
      console.log(expression);
      var xhr = new XMLHttpRequest();
      xhr.open("POST", "/calculate", true);
      xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      xhr.onload = function () {
        console.log(xhr.status === 200);

        if (xhr.status === 200) {
          document.getElementById("expression").value = xhr.responseText;
        } else {
          console.log("Request failed.  Returned status of " + xhr.status);
        }
      };
      xhr.send("expression=" + encodeURIComponent(expression));
    }
  </script>
</html>
