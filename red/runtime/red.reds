Red/System [
	Title:   "Red runtime wrapper"
	Author:  "Nenad Rakocevic"
	File: 	 %red.reds
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2012 Nenad Rakocevic. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/dockimbel/Red/blob/master/BSL-License.txt
	}
]

red: context [
	;-- Runtime sub-system --
	
	#include %macros.reds
	#include %tools.reds
	
	#switch OS [										;-- loading OS-specific bindings
		Windows  [#include %platform/win32.reds]
		Syllable [#include %platform/syllable.reds]
		MacOSX	 [#include %platform/darwin.reds]
		#default [#include %platform/linux.reds]
	]
	
	;#include %threads.reds
	#include %allocator.reds
	;#include %collector.reds
	
	;-- Datatypes --
	
	#include %datatypes/structures.reds
	#include %datatypes/common.reds
	#include %unicode.reds
	
	#include %datatypes/datatype.reds
	#include %datatypes/unset.reds
	#include %datatypes/none.reds
	#include %datatypes/logic.reds
	#include %datatypes/block.reds
	#include %datatypes/string.reds
	#include %datatypes/integer.reds
	#include %datatypes/symbol.reds
	#include %datatypes/context.reds
	#include %datatypes/word.reds
	#include %datatypes/lit-word.reds
	#include %datatypes/set-word.reds
	#include %datatypes/get-word.reds
	#include %datatypes/refinement.reds
	#include %datatypes/char.reds
	#include %datatypes/native.reds
	#include %datatypes/action.reds
	#include %datatypes/op.reds
	#include %datatypes/path.reds
	#include %datatypes/lit-path.reds
	#include %datatypes/set-path.reds
	#include %datatypes/get-path.reds
	#include %datatypes/function.reds
	#include %datatypes/routine.reds
	#include %datatypes/paren.reds
	#include %datatypes/issue.reds
	#include %datatypes/file.reds
	#include %datatypes/list.reds
	
	;-- Debugging helpers --
	
	#include %debug-tools.reds
	
	;-- Core --
	#include %tokenizer.reds
	#include %actions.reds
	#include %natives.reds
	#include %stack.reds
	#include %interpreter.reds
	#include %simple-io.reds							;-- temporary file IO support

	_root:	 	declare red-block!						;-- statically alloc root cell for bootstrapping
	root:	 	declare red-block!						;-- root block		
	symbols: 	declare red-block! 						;-- symbols table
	global-ctx: declare red-context!					;-- global context

	;-- Booting... --
	
	init: does [
		platform/init
		init-mem										;@@ needs a local context
	
		name-table: as names! allocate 50 * size? names!	 ;-- datatype names table
		action-table: as int-ptr! allocate 256 * 50 * size? pointer! ;-- actions jump table	

		datatype/init
		unset/init
		none/init
		logic/init
		block/init
		string/init
		integer/init
		symbol/init
		_context/init
		word/init
		lit-word/init
		set-word/init
		get-word/init
		refinement/init
		char/init
		native/init
		action/init
		op/init
		path/init
		lit-path/init
		set-path/init
		get-path/init
		_function/init
		routine/init
		paren/init
		issue/init
		file/init
		list/init 
		
		actions/init
		
		;-- initialize memory before anything else
		alloc-node-frame nodes-per-frame				;-- 5k nodes
		alloc-series-frame								;-- first frame of 512KB

		root:	 	block/make-in null 2000	
		symbols: 	block/make-in root 1000
		global-ctx: _context/create root 1000 no

		datatype/make-words								;-- build datatype names as word! values
		words/build										;-- create symbols used internally
		refinements/build								;-- create refinements used internally
		natives/init									;-- native specific init code
		
		stack/init
		
		#if debug? = yes [
			verbosity: 0
			datatype/verbose:	verbosity
			unset/verbose:		verbosity
			none/verbose:		verbosity
			logic/verbose:		verbosity
			block/verbose:		verbosity
			string/verbose:		verbosity
			integer/verbose:	verbosity
			symbol/verbose:		verbosity
			_context/verbose:	verbosity
			word/verbose:		verbosity
			set-word/verbose:	verbosity
			refinement/verbose:	verbosity
			char/verbose:		verbosity
			path/verbose:		verbosity
			lit-path/verbose:	verbosity
			set-path/verbose:	verbosity
			get-path/verbose:	verbosity
			_function/verbose:	verbosity
			routine/verbose:	verbosity
			paren/verbose:		verbosity
			issue/verbose:		verbosity
			file/verbose:		verbosity

			actions/verbose:	verbosity
			natives/verbose:	verbosity

			stack/verbose:		verbosity
			unicode/verbose:	verbosity
		]
	]
]