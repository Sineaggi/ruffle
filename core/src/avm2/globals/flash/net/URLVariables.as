package flash.net {
    import flash.utils.escapeMultiByte;
    import flash.utils.unescapeMultiByte;

    public dynamic class URLVariables {
	// TODO: construct from String
	public function URLVariables() {}

        public function toString(): String {
	    var acc : String = ""
	    var sep :String = ""
	    for (p in this) {
		var pe : String = escapeMultiByte(p);
		var val = this[p];
		if (val is Array) {
		    for (i in val) {
			acc += sep;
		        acc += pe;
                        acc += "=";
		        acc += escapeMultiByte(val[i]);
			sep = "&";
 		    }
		    continue;
		}
		acc += sep;
		acc += pe;
		acc += "=";
		acc += escapeMultiByte(val);
		sep="&";
	    }
	    return acc;
	}

        public function decode(source: String): void {
			// todo: split is undefined? how?
            for (var element: String in source.split("&")) {
                var parts = element.split("=");
                var key = unescapeMultiByte(parts[0]);
                if (this[key] == null) {
					// initialize
                    this[key] = unescapeMultiByte(parts[1]);
                } else if (this[key] is Array) {
					// append to array
                    this[key].append(unescapeMultiByte(parts[1]));
                } else {
					// else convert single to array
                    var formerValue = this[key];
                    var array: Array = new Array(formerValue, unescapeMultiByte(parts[1]));
                    this[key] = array;
                }
            }
        }

    }
}
