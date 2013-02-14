have_process_count() {
  pattern=`echo $1 | sed 's/\(.\)/[\1]/'`
  expected_count=$2
  process_list=`ps waux|grep "[0-9][0-9] $pattern"`
  echo "$process_list" |
    sed 's/^/      /g' |
    sed 's/[ ]*$//g'  # for ?some? reason unicorn jobs have a bunch of ugly trailing whitespace
  process_count=`[[ -z $process_list ]] && echo 0 || echo "$process_list"|wc -l`
  assert equal $process_count $expected_count
}
