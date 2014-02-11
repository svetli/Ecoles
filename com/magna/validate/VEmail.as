package com.magna.validate
{
	public class VEmail extends AValidate implements IValidate
	{
		private var _localPart:String;
		private var _hostName:String;
		
		public static const INVALID_FORMAT:String 		= "Is no valid email address in the basic format local-part@hostname";
		public static const INVALID_LOCAL_PART:String 	= "Is no valid local part for email address";
		public static const INVALID_HOSTNAME:String 	= "Is no valid hostname part for email address";
		public static const LENGTH_EXCEEDED:String 		= "Exceeds the allowed length";
		
		public function VEmail()
		{
			
		}
		
		/**
		* Defined by IValidate
		*
		* Returns true if and only if $value is a valid email address
		* according to RFC2822
		*
		* @link   http://www.ietf.org/rfc/rfc2822.txt RFC2822
		* @link   http://www.columbia.edu/kermit/ascii.html US-ASCII characters
		* @param  String $value
		* @return boolean
		*/
		override public function isValid(value) : Boolean
		{
			_setValue(new String(value));

			var regExpAT:RegExp = /^(.+)@([^@]+)$/;
			var resultAT:Object = regExpAT.exec(_value);
			
			if( !_value.match(regExpAT) )
			{
				_message = INVALID_FORMAT
				return false;
			}
			
			_localPart = resultAT[1];
			_hostName = resultAT[2];
			
			if (_localPart.length > 64 || _hostName.length > 255)
			{
				_message = LENGTH_EXCEEDED;
				return false;
			}			
			
			var local:Boolean = _validateLocalPart();
			var host:Boolean = _validateHostnamePart();
			
			if (local && host)
			{
                return true;
            }
			
			return false;
		}
		
		private function _validateLocalPart() : Boolean
		{
			var result:Boolean = true;
			
			// Dot-atom characters are: 1*atext *("." 1*atext)
			// atext: ALPHA / DIGIT / and "!", "#", "$", "%", "&", "'", "*",
			//        "+", "-", "/", "=", "?", "^", "_", "`", "{", "|", "}", "~"
			var atext:String = 'a-zA-Z0-9\x21\x23\x24\x25\x26\x27\x2a\x2b\x2d\x2f\x3d\x3f\x5e\x5f\x60\x7b\x7c\x7d\x7e';
			var regExp:RegExp = new RegExp("^[" + atext + "]+(\x2e+[" + atext + "]+)*$");
			
			if( _localPart.match(regExp) )
			{
				result = true;
			}
			else
			{
				// Try quoted string format
				// Quoted-string characters are: DQUOTE *([FWS] qtext/quoted-pair) [FWS] DQUOTE
				// qtext: Non white space controls, and the rest of the US-ASCII characters not
				// including "\" or the quote character
				var noWsCtl:String = '\x01-\x08\x0b\x0c\x0e-\x1f\x7f';
				var qtext:String   = noWsCtl + '\x21\x23-\x5b\x5d-\x7e';
				var ws:String      = '\x20\x09';
				
				regExp = new RegExp("^\x22([" + ws + qtext + "])*[" + ws + "]?\x22$");
				
				if( _localPart.match(regExp) )
				{
					result = true;
				}
				else
				{
					result = false;
					_message = INVALID_LOCAL_PART;
				}
			}
			
			return result;
		}
		
		private function _validateHostnamePart() : Boolean
		{
			var regExpTLD:RegExp = /([^.]{2,10})$/i;
			var resultTLD:Object = regExpTLD.exec(_hostName);
			
			// check tld
			if( !_hostName.match(regExpTLD) )
			{
				_message = INVALID_HOSTNAME;
				return false;
			}

			if( !_checkTLD(resultTLD[1]) )
			{
				_message = INVALID_HOSTNAME;
				return false;
			}
			
			if( _hostName.match(/^[a-z0-9\x2d]{1,63}$/i) )
			{
				_message = INVALID_HOSTNAME;
				return false;
			}
			
			return true;
		}
		
		private function _checkTLD(tld:String) : Boolean
		{
			var i:Number = 0;
			
			for(i=0; i < validTlds.length; i++)
			{
				if( validTlds[i] == tld )
				{
					return true;
				}
			}
			
			return false;
		}
		
		protected var validTlds:Array = [
			'ac', 'ad', 'ae', 'aero', 'af', 'ag', 'ai', 'al', 'am', 'an', 'ao', 'aq', 'ar', 'arpa',
			'as', 'asia', 'at', 'au', 'aw', 'ax', 'az', 'ba', 'bb', 'bd', 'be', 'bf', 'bg', 'bh', 'bi',
			'biz', 'bj', 'bm', 'bn', 'bo', 'br', 'bs', 'bt', 'bv', 'bw', 'by', 'bz', 'ca', 'cat', 'cc',
			'cd', 'cf', 'cg', 'ch', 'ci', 'ck', 'cl', 'cm', 'cn', 'co', 'com', 'coop', 'cr', 'cu',
			'cv', 'cx', 'cy', 'cz', 'de', 'dj', 'dk', 'dm', 'do', 'dz', 'ec', 'edu', 'ee', 'eg', 'er',
			'es', 'et', 'eu', 'fi', 'fj', 'fk', 'fm', 'fo', 'fr', 'ga', 'gb', 'gd', 'ge', 'gf', 'gg',
			'gh', 'gi', 'gl', 'gm', 'gn', 'gov', 'gp', 'gq', 'gr', 'gs', 'gt', 'gu', 'gw', 'gy', 'hk',
			'hm', 'hn', 'hr', 'ht', 'hu', 'id', 'ie', 'il', 'im', 'in', 'info', 'int', 'io', 'iq',
			'ir', 'is', 'it', 'je', 'jm', 'jo', 'jobs', 'jp', 'ke', 'kg', 'kh', 'ki', 'km', 'kn', 'kp',
			'kr', 'kw', 'ky', 'kz', 'la', 'lb', 'lc', 'li', 'lk', 'lr', 'ls', 'lt', 'lu', 'lv', 'ly',
			'ma', 'mc', 'md', 'me', 'mg', 'mh', 'mil', 'mk', 'ml', 'mm', 'mn', 'mo', 'mobi', 'mp',
			'mq', 'mr', 'ms', 'mt', 'mu', 'museum', 'mv', 'mw', 'mx', 'my', 'mz', 'na', 'name', 'nc',
			'ne', 'net', 'nf', 'ng', 'ni', 'nl', 'no', 'np', 'nr', 'nu', 'nz', 'om', 'org', 'pa', 'pe',
			'pf', 'pg', 'ph', 'pk', 'pl', 'pm', 'pn', 'pr', 'pro', 'ps', 'pt', 'pw', 'py', 'qa', 're',
			'ro', 'rs', 'ru', 'rw', 'sa', 'sb', 'sc', 'sd', 'se', 'sg', 'sh', 'si', 'sj', 'sk', 'sl',
			'sm', 'sn', 'so', 'sr', 'st', 'su', 'sv', 'sy', 'sz', 'tc', 'td', 'tel', 'tf', 'tg', 'th',
			'tj', 'tk', 'tl', 'tm', 'tn', 'to', 'tp', 'tr', 'travel', 'tt', 'tv', 'tw', 'tz', 'ua',
			'ug', 'uk', 'um', 'us', 'uy', 'uz', 'va', 'vc', 've', 'vg', 'vi', 'vn', 'vu', 'wf', 'ws',
			'ye', 'yt', 'yu', 'za', 'zm', 'zw'
		];		
	}
	
}