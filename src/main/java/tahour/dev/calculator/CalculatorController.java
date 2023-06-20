package tahour.dev.calculator;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class CalculatorController {

    @RequestMapping("/")
    public String index() {
        return "calculator";
    }

    @PostMapping("/calculate")
    @ResponseBody
    public String calculate(@RequestParam("expression") String expression) {
        // Initialize variables for the operator and operands
        char operator = '+';
        double num1 = 0;
        double num2 = 0;
        boolean negative = false;
        boolean isMultiplicationOrDivision = false;
        boolean isDecimal = false;

        System.out.println("Expression Length" + expression.length());


        // Loop through the expression to parse the operator and operands
        for (int i = 0; i < expression.length(); i++) {
            char c = expression.charAt(i);
            System.out.println("index i" + i);
            System.out.println("Character: " + c);

            if (c == '-') {
               
                if (i == 0 || (!Character.isDigit(expression.charAt(i - 1)) && expression.charAt(i - 1) != '.')) {
                    // Handle negative number
                    negative = true;
                } else {
                    // Handle subtraction operation
                    if (!isMultiplicationOrDivision) {
                        operator = '-';
                    } else {
                        num2 = -num2;
                    }
                }
            } else if (Character.isDigit(c) || c == '.') {
                // Parse the operand
                String num = "";
                while (i < expression.length() && (Character.isDigit(expression.charAt(i)) || expression.charAt(i) == '.')) {
                    num += expression.charAt(i++);
                    if (expression.charAt(i - 1) == '.') {
                        isDecimal = true;
                    }
                }
                i--;
                double d = Double.parseDouble(num);
                if (negative) {
                    d = -d;
                    negative = false;
                }
                if (isMultiplicationOrDivision) {
                    if (operator == 'x') {
                        if (num2 == 0) {
                            num2 = 1;
                        }
                        num2 *= d;
                    } else {
                        if (num2 == 0) {
                            num2 = 1;
                        }
                        if (d < 0) {
                            num1 *= -1;
                            num2 = -num2;
                            d = -d;
                        }
                        num1 /= d;
                    }
                } else {
                    if (operator == '+') {
                        num1 += d;
                    } else {
                        num1 -= d;
                    }
                }
            } else {
                if (c == 'x' || c == '/') {
                    isMultiplicationOrDivision = true;
                } else {
                    isMultiplicationOrDivision = false;
                }
                // Set the operator
                operator = c;
            }
        }

        // Calculate the result based on the operator and operands
        double result = 0;
        switch (operator) {
            case '+':
                result = num1;
                break;
            case '-':
                result = num1;
                break;
            case 'x':
                if (num2 == 0) {
                    num2 = 1;
                }
                result = num1 * num2;
                break;
            case '/':
                if (num2 == 0) {
                    num2 = 1;
                }
                result = num1 / num2;
                break;
        }

        // Check if the result is an integer or a double
        boolean isInteger = (result == Math.floor(result)) && !Double.isInfinite(result) && !isDecimal;
        if (isInteger) {
            int intResult = (int) result;
            return Integer.toString(intResult);
        } else {
            return Double.toString(result);
        }
    }
}