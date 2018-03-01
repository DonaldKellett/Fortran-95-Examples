program ScrabbleWordScoreCalculator
  implicit none
  integer, dimension(26) :: letterScores = &
  (/1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10/)
  character(len=100) :: word
  integer :: score = 0, n, i
  print "(A53)", "Please enter a word to calculate its Scrabble score: "
  read(*, *) word
  do i = 1, len(trim(word))
    n = ichar(word(i:i))
    if (n >= 97) then
      score = score + letterScores(n - 96)
    else
      score = score + letterScores(n - 64)
    end if
  end do
  print "(A36, I0)", "The Scrabble score of your word is: ", score
end program ScrabbleWordScoreCalculator
