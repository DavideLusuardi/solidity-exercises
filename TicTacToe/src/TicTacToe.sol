// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TicTacToe {
    /* 
        This exercise assumes you know how to manipulate nested array.
        1. This contract checks if TicTacToe board is winning or not.
        2. Write your code in `isWinning` function that returns true if a board is winning
           or false if not.
        3. Board contains 1's and 0's elements and it is also a 3x3 nested array.
    */

    // function isWinning(uint8[3][3] memory board) public pure returns (bool) {
    //     if ((board[0][0] == board[0][1] && board[0][1] == board[0][2]) ||
    //         (board[1][0] == board[1][1] && board[1][1] == board[1][2]) ||
    //         (board[2][0] == board[2][1] && board[2][1] == board[2][2]) ||
    //         (board[0][0] == board[1][0] && board[1][0] == board[2][0]) ||
    //         (board[0][1] == board[1][1] && board[1][1] == board[2][1]) ||
    //         (board[0][2] == board[1][2] && board[1][2] == board[2][2]) ||
    //         (board[0][0] == board[1][1] && board[1][1] == board[2][2]) ||
    //         (board[0][2] == board[1][1] && board[1][1] == board[2][0])
    //     ) {
    //         return true;
    //     }
    //     return false;
    // }

    function isWinning(uint8[3][3] memory board) public pure returns (bool) {
        for (uint8 i = 0; i < board.length; i++) {
            uint8 t = 0;
            for (uint8 j = 0; j < board[i].length; j++) {
                t += board[i][j];
            }
            if (t == board.length) {
                return true;
            }
        }
        for (uint8 j = 0; j < board.length; j++) {
            uint8 t = 0;
            for (uint8 i = 0; i < board.length; i++) {
                t += board[i][j];
            }
            if (t == board.length) {
                return true;
            }
        }
        uint8 t = 0;
        for (uint8 i = 0; i < board.length; i++) {
            t += board[i][i];
        }
        if (t == board.length) {
            return true;
        }
        
        t = 0;
        for (uint8 i = 0; i < board.length; i++) {
            t += board[i][2-i];
        }
        if (t == board.length) {
            return true;
        }
        
        return false;
    }
}
