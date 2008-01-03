#ifndef ERROR
	#define ERROR

	#include<string>
	#include<exception>

	using namespace std;

	class general_exception
	{
	public:
		general_exception(string str_para): str(str_para) {}
		string str;
		
	};


	class var_nonpositive_exception : public general_exception
	{
	public:
		var_nonpositive_exception(string str_para): general_exception(str_para) {}
	};


	class memory_exception : public general_exception
	{
	public:
		memory_exception(string str_para): general_exception(str_para) {}
	};


	class file_exception : public general_exception
	{
	public:
		file_exception(string str_para): general_exception(str_para) {}
	};

#endif
