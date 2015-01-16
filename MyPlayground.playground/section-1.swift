// Playground - noun: a place where people can play

import UIKit

let data = "2015-01-15"

let rangeOfDay = Range(start: (advance(data.endIndex, -8)), end: (advance(data.endIndex, -6)))
let dia = data.substringWithRange(rangeOfDay)
dia

let rangeOfMouth = Range(start: (advance(data.endIndex, -5)), end: (advance(data.endIndex, -3)))
let mes = data.substringWithRange(rangeOfMouth)
mes

let rangeOfYear = Range(start: (advance(data.endIndex, -10)), end: (advance(data.endIndex, -6)))
let ano = data.substringWithRange(rangeOfYear)
ano

println(dia + "/" + mes + "/" + ano)
