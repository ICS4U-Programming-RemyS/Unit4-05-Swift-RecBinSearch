// BinarySearch.swift
//
// Created by Remy Skelton
// Created on 2025-May-2
// Version 1.0
// Copyright (c) Remy Skelton. All rights reserved.
//
// This program reads multiple lines of strings from an input file.
// It checks two lines at a time:
// one for an array and one for the number to search.
// If both are valid, it searches for the number in the array.

// Import Foundation
import Foundation

// Define the InputError enum to handle errors
enum InputError: Error {
    case invalidInput
}

// Do catch block to catch any errors
do {
    // Welcome message
    print("Welcome to the Recursive Binary Search program!")
    print("This program will read an array ", terminator: "")
    print("and a number from a file. If valid it will display", terminator: "")
    print(" the index it was found at in the output file.")

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

// While loop to read each array-number pair
    while position < inputLines.count {

        // Get the current line and trim spaces
        let currentLine = inputLines[position].trimmingCharacters(in: .whitespaces)
        position += 1

        // Split the line by spaces to create the string array
        let unsortedArrayStr = currentLine.components(separatedBy: " ")

        // Declare the integer array
        var sortedArray = [Int]()

        // Check if the line is empty or only spaces
        if unsortedArrayStr.count == 1 && unsortedArrayStr[0] == "" {
            outputStr += "Invalid: \(currentLine) is not a valid array of integers.\n"
            continue
        }

        // Try converting string values to integers
        do {
            for index in 0..<unsortedArrayStr.count {
                if let intVal = Int(unsortedArrayStr[index]) {
                    sortedArray.append(intVal)
                } else {
                    throw InputError.invalidInput
                }
            }
        } catch {
            // If conversion fails, write an error and continue
            outputStr += "Invalid: \(currentLine) is not a valid array of integers.\n"
            continue
        }

        // Sort the array
        sortedArray.sort()

        // Check if there is a next line for the search number
        if position < inputLines.count {
            // Get the next line and trim spaces
            let numberStr = inputLines[position].trimmingCharacters(in: .whitespaces)
            position += 1

            // Try converting the string to an integer
            if let number = Int(numberStr) {
                // Check if the number is negative
                if number < 0 {
                    outputStr += "\(sortedArray)\nInvalid: \(numberStr) is not a valid positive integer.\n"
                    continue
                } else {
                    // Set low = 0 and high = length of array - 1
                    let low = 0
                    let high = sortedArray.count - 1

                    // Call the recursive binary search function
                    let indexBiSer = recBinSer(array: sortedArray, number: number, low: low, high: high)


                    // Check if the number is in the array
                    if indexBiSer == -1 {
                        outputStr += "\(sortedArray)\nInvalid: \(number) is not in the array.\n"
                        continue
                    } else {
                        outputStr += "\(sortedArray)\nThe value \(number) is at index \(indexBiSer) in the array.\n"
                    }
                }

            } else {
                // If number string is not a valid integer
                outputStr += "\(sortedArray)\nInvalid: \(numberStr) is not a valid positive integer.\n"
                continue
            }
        }
    }

    // Write to output.txt
    try outputStr.write(toFile: outputFile, atomically: true, encoding: .utf8)

    // Print the that the output is written to the file
    print("Binary Search results written to output.txt.")

} catch {
    // Print the error message
    print("Error: \(error)")
}

// Function to perform recursive binary search
func recBinSer(array: [Int], number: Int, low: Int, high: Int) -> Int {
    // Set mid to the middle index of the array
    let mid = (low + high) / 2

    // Check if the low index is greater than the high index
    if low > high {
        // Return -1 if the number is not found
        return -1

    } else if array[mid] == number {
        // Check if the number is equal to the middle element
        // Return the index of the number in the array
        return mid

    } else {
        // Check if the number is less than the middle element
        if number < array[mid] {
            // Call the method recursively with the low index and mid - 1
            return recBinSer(array: array, number: number, low: low, high: mid - 1)

        } else {
            // Call the method recursively with the mid + 1 and high index
            return recBinSer(array: array, number: number, low: mid + 1, high: high)
        }
    }
}
