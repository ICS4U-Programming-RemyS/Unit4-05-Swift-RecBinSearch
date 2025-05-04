// Fibonacci.swift
//
// Created by Remy Skelton
// Created on 2025-April-6
// Version 1.0
// Copyright (c) Remy Skelton. All rights reserved.
//
// This program will read an multiple lines of string from the a input file.
// If the data is valid then it will calculate the value at the index
// in the fibonacci sequence and write the result to an output file.

// Import Foundation
import Foundation

// Define the InputError enum to handle errors
enum InputError: Error {
    case invalidInput
}

// Do catch block to catch any errors
do {
    // Welcome message
    print("Welcome to the Fibonacci program!")
    print("This program reads multiple lines", terminator: "")
    print(" of strings from input.txt, if valid it will ", terminator: "")
    print("calculates the value at the index in the fibonacci ", terminator: "")
    print("sequence, and writes the result to output.txt.")

    // Initialize output string
    var outputStr = ""

    // Define the file paths
    let inputFile = "input.txt"
    let outputFile = "output.txt"

    // Open the input file for reading
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        throw InputError.invalidInput
    }

    // Read the contents of the input file
    let inputData = input.readDataToEndOfFile()

    // Convert the data to a string
    guard let inputStr = String(data: inputData, encoding: .utf8) else {
        // Throw an error if the data cannot be converted to a string
        throw InputError.invalidInput
    }

    // Split the input into lines
    let inputLines = inputStr.components(separatedBy: "\n")

    // Create position variable
    var position = 0

    // While loop to read each line
    while position < inputLines.count {

        // Split the line into integers
        let currentLine = inputLines[position]
        let currentLineArray = currentLine.components(separatedBy: " ")

        // For loop to go through array
        for numberStr in currentLineArray {
            // Convert the string to an integer
            guard let number = Int(numberStr) else {
                // Write an error message to the output string
                outputStr += "Invalid: \(numberStr) is not a valid positive integer.\n"
                // Continue to the next iteration
                continue
            }

            // Check if the integer is negative
            if number < 0 {
                // Write an error message to the output string
                outputStr += "Invalid: \(numberStr) is not a valid positive integer.\n"
            } else {
                // Call the recFib function
                let valueFib = recFib(number: number)

                // Append the result to the output string
                outputStr += "The value in the Fibonacci Sequence at \(number) = \(valueFib)\n"
            }
        }
        // Increment the position
        position += 1
    }

    // Write to output.txt
    try outputStr.write(toFile: outputFile, atomically: true, encoding: .utf8)

    // Print the that the output is written to the file
    print("Fibonacci written to output.txt.")

} catch {
    // Print the error message
    print("Error: \(error)")
}

// Function to to find fibonacci of integer using recursion
func recFib(number: Int) -> Int {
    // Base case: if the number is less than or equal to 1 return the number
    if number <= 1 {
        // Return the number if it is 0 or 1
        return number
    } else {
        // Return the sum of the last 2 term in the Fibonacci sequence
        return recFib(number: number - 1) + recFib(number: number - 2)

    }
}
