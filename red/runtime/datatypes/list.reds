Red/System []

list: context [
    verbose: 0
    
	make: func [
		proto 	[red-value!]
		spec  	[red-value!]
		return: [red-list!]
		/local
		list 	[red-list!]
	][
		#if debug? = yes [if verbose > 0 [probe "list/make"]]

		list: as red-list! block/make proto spec 
		list/header: TYPE_LIST
		list
	]

    init: does [
		datatype/register [
			TYPE_LIST
			TYPE_VALUE
			"list!"
			;-- General actions --
			:make
			null			;random
			null			;reflect
			null			;to
			null			;:form
			null			;mold
			null			;get-path
			null			;set-path
			null			;compare
			;-- Scalar actions --
			null			;absolute
			null			;add
			null			;divide
			null			;multiply
			null			;negate
			null			;power
			null			;remainder
			null			;round
			null			;subtract
			null			;even?
			null			;odd?
			;-- Bitwise actions --
			null			;and~
			null			;complement
			null			;or~
			null			;xor~
			;-- Series actions --
			null			;append
			null			;at
			null			;back
			null			;change
			null			;clear
			null			;copy
			null			;find
			null			;head
			null			;head?
			null			;index?
			null			;insert
			null			;length?
			null			;next
			null			;pick
			null			;poke
			null			;remove
			null			;reverse
			null			;select
			null			;sort
			null			;skip
			null			;swap
			null			;tail
			null			;tail?
			null			;take
			null			;trim
			;-- I/O actions --
			null			;create
			null			;close
			null			;delete
			null			;modify
			null			;open
			null			;open?
			null			;query
			null			;read
			null			;rename
			null			;update
			null			;write
		]
	]
]