def loc()
	f = File.popen("find . -iregex '^.*\\.[hm]$' | xargs cat | wc -l")
	res = f.lines.to_a[0].to_i
	f.close()
	res
end

def commits()
  f = File.popen("git log --reverse --pretty=format:'%H'")
  res = f.lines.to_a
  f.close()
  res
end

previous_branch = "master"

system "git branch loccounter"
system "git checkout loccounter"

locs = []
commits = commits()
commits.each { |c|
	system "git reset --hard #{c}"
	l = loc()
	locs << l
	puts l
}

puts "LOCs by commit:\n"
puts locs

system "git checkout #{previous_branch}"
system "git branch -D loccounter"