BEGIN { 
  mos["no-month"] = 0
  counts[0][0][0] = 0
} 

function bump_count(array_name, index_value) {
  if (index_value in array_name) { 
    array_name[index_value] = array_name[index_value] + 1 
  } else { 
    array_name[index_value] = 1
  }
} 

function bump(key1, key2, key3) {
  if (NEVER) {
    if (! key1 in counts) {
      print("assigning " key1)
      counts[key1] = "x"
    } 
    if (! key2 in counts[key1]) {
      print("    assigning " key2)
      counts[key1][key2] = "y"
    } 
    if (! key3 in counts[key1][key2]) {
      print("        assigning " key3)
      counts[key1][key2][key3] = 0
    }
  } else {
    if (counts[key1][key2][key3] == "")
      counts[key1][key2][key3] = 0  
  }

  counts[key1][key2][key3] = counts[key1][key2][key3] + 1
}

{
  # year, month, day
  bump($3, $1, $2)
}

END {
  for (y in counts)
    for (m in counts[y])
      for (d in counts[y][m])
        print (y " " m " " d ": " counts[y][m][d])
}


/never/ {
  if ($1 in mos) { 
    mos[$1] = mos[$1] + 1 
  } else { 
    mos[$1] = 1
  } 
} 

/END/ { 
  for (m in mos) 
    print m ": " mos[m] 
}
