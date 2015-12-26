class standardnode::apt {
	class { '::apt':
		update => {
			frequency => 'daily',
		},
	}
}
