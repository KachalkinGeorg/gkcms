<?php

class Autokeys {

    private $contents;
    private $keywords;
    private $wordLengthMin;
    private $wordOccuredMin;
    private $wordLengthMax;
    private $wordGoodArray;
    private $wordBlockArray;
    private $wordMaxCount;
    private $wordB;
    private $wordAddTitle;
    private $wordTitle;

    public function __construct($params) {
        $this->wordGoodArray = array();
        $this->wordBlockArray = array();
        $this->wordLengthMin = $params['min_word_length'];
        $this->wordOccuredMin = $params['min_word_occur'];
        $this->wordLengthMax = $params['max_word_length'];
        $this->wordMaxCount = $params['word_count'];
        if( $params['good_b'] )
            $this->wordB = true;
        if( $params['add_title'] ) {
            $this->wordAddTitle = $params['add_title'];
            $this->wordTitle = $params['title'];
            $content = '';
            for($i=0; $i<$this->wordAddTitle;$i++)
                $content .= $this->wordTitle.' ';
            $params['content'] = $content.' '.$params['content'];
        }
        if( trim($params['block_array']) and $params['block_word'] )
            $this->wordBlockArray = mb_split( '[\s\r\n|\r|\n]+', $params['block_array'] );
        if( trim($params['good_array']) and $params['good_word'] )
            $this->wordGoodArray = mb_split( '[\s|\r\n|\r|\n]+', $params['good_array'] );
        $this->contents = $this->replace_chars($params['content']);
    }

    public function replace_chars($content) {
        $parse = new Parse();
        $content = mb_strtolower($content, 'UTF-8');
        $content = $parse->bbcodes($content);
        if( $this->wordB )
            $content = preg_replace('/<b>(.*)<\/b>/si','$1 $1',$content);
        $content = strip_tags($content);
        $content = preg_replace( '/\d+/', ' ', $content );
        $punctuations = array(',', '.', '…', ')', '(', "'", '"', '<', '>', ';', '!', '?', '/', '-', '—', '_',
        '[', ']', ':', '+', '=', '#', '$', '&quot;', '&copy;', '&gt;', '&lt;', chr(10), chr(13), chr(9));
        $content = str_replace($punctuations, ' ', $content);

        return $content;
    }

    public function parse_words() {
        mb_regex_encoding( 'utf-8' );
        $content = mb_split( '\s+', $this->contents );
        $content = array_diff( $content, $this->wordBlockArray );
        $content = array_merge( $content, $this->wordGoodArray );
        $content = array_count_values( $content );
        arsort( $content, SORT_NUMERIC );

        $tags = array();
        foreach( $content as $word => $number  ){
            $word = trim( $word );
            if( mb_strlen($word, 'utf-8') >= $this->wordLengthMin and mb_strlen($word, 'utf-8') <= $this->wordLengthMax and !is_numeric($word) ){
                if( intval($number) >= intval($this->wordOccuredMin) )
                    $tags[] = $word;
                else break;
            }
        }
        if ( $this->wordMaxCount )
            $tags = array_slice($tags, 0, $this->wordMaxCount);

        return implode(',', $tags);
    }
}

function akeysGetKeys($params) {
    global $config;

	if ( file_exists($stopFile = extras_dir .'/autokeys/config/stop-words/' . $config['default_lang'] . '.sw.txt') ){
		$stopText  = file_get_contents( $stopFile );
	}
	if ( file_exists($allowFile = extras_dir .'/autokeys/config/allow-words.txt') ){
		$allowText  = file_get_contents( $allowFile );
	}

    $cfg = array(
        'content' => $params['content'].' this is content',
        'title' => $params['title'],
        'min_word_length' => (intval(pluginGetVariable('autokeys','length'))) ? intval(pluginGetVariable('autokeys','length')) : 5,
        'max_word_length' => (intval(pluginGetVariable('autokeys','sub'))) ? intval(pluginGetVariable('autokeys','sub')) : 100,
        'min_word_occur' => (intval(pluginGetVariable('autokeys','occur'))) ? intval(pluginGetVariable('autokeys','occur')) : 2,
        'add_title' => (intval(pluginGetVariable('autokeys','add_title'))) ? intval(pluginGetVariable('autokeys','add_title')) : 1,
        'word_sum' => (intval(pluginGetVariable('autokeys','sum'))) ? intval(pluginGetVariable('autokeys','sum')) : 245,
        'word_count' => (intval(pluginGetVariable('autokeys','count'))) ? intval(pluginGetVariable('autokeys','count')) : 8,
        'good_b' => pluginGetVariable('autokeys','good_b') ? pluginGetVariable('autokeys','good_b') : false,
        'block_word' => pluginGetVariable('autokeys','block_y') ? pluginGetVariable('autokeys','block_y') : false,
        'block_array' => $stopText,
        'good_word' => pluginGetVariable('autokeys','good_y') ? pluginGetVariable('autokeys','good_y') : false,
        'good_array' => $allowText,
    );

    $autokeys = new Autokeys($cfg);
    $keyword = $autokeys->parse_words();
    if ( mb_strlen($keyword, 'UTF-8') > $cfg['word_sum'] ) {
        $keyword = mb_substr($keyword, 0, $cfg['word_sum'], 'UTF-8');
        $keyword = mb_substr($words, 0, mb_strrpos($keyword, ',', 'UTF-8'), 'UTF-8');
    }

    return $keyword;
}
