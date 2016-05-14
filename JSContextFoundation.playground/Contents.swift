//: Playground - noun: a place where people can play

import JSContextFoundation

let jsContext = JSContextFoundation()
jsContext!.exceptionHandler = { context, exception in
    print(exception)
}
jsContext.evaluateScript("console.log(1, 2, 3)")
jsContext.evaluateScript("console.info(window)")
jsContext.evaluateScript("console.error('a', {a: 3, b: 4}, [1, 2, 3])")
