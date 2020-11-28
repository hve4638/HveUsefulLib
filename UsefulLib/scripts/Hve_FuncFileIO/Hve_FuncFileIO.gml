function load_string(fname)
{
	var f, str;

	f = file_text_open_read(fname);
	str = "";

	while(!file_text_eof(f))
	{
		str += file_text_read_string(f);
	
		if file_text_eoln(f)
		{
			str += "\n"
			file_text_readln(f)
		}
	}
	file_text_close(f);

	return str;
}

function load_json(fname)
{
	var _str = load_string(fname);

	return json_decode(_str);
}