BEGIN { 
  # counts[0][0][0] = 0
  months["jan"] = 1
  months["feb"] = 2
  months["mar"] = 3
  months["apr"] = 4
  months["may"] = 5
  months["jun"] = 6
  months["jul"] = 7
  months["aug"] = 8
  months["sep"] = 9
  months["oct"] = 10
  months["nov"] = 11
  months["dec"] = 12

  WIDTH = 32
} 

function bump(key1, key2, key3) {

  if (counts[key1][key2][key3] == "")
    counts[key1][key2][key3] = 0  

  counts[key1][key2][key3] = counts[key1][key2][key3] + 1
}

{
  # year, month, day
  printf("%s %s %s\n", $1, $2, $3)

  day = months[tolower($2)]
  bump($1, day, $3)
}

END {
  # day view
  if (day_view) {
    for (y in counts)
    for (m in counts[y])
      for (d in counts[y][m])
        print (y " " m " " d ": " counts[y][m][d])
  }


  # month view
  if (month_view) {
    for (y in counts) {
      for (m in counts[y]) {
        m_count = 0
        for (d in counts[y][m]) {
          m_count = m_count + counts[y][m][d]
        } 
        print y " " m ": " m_count
      }
    }
  }

  # get max value for scaling
  max_count = 0
  for (y in counts) {
    for (m in counts[y]) {
      m_count = 0
      for (d in counts[y][m]) {
        m_count = m_count + counts[y][m][d]
      } 
      if (m_count > max_count)
        max_count = m_count
    }
  }

  scale = WIDTH / max_count
  # printf("max: %d\nscale: %f\n", max_count, scale)

  for (y in counts) {
    for (m in counts[y]) {
      m_count = 0
      for (d in counts[y][m]) {
        m_count = m_count + counts[y][m][d]
      } 
      printf("%2d/%4d: ", m, y)
      n = m_count * scale
      for (i = 0; i < n; i++) 
        printf("*")
      printf("\n")
    }
  }
}

