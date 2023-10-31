<?php

	if (!defined('NGCMS')) die ('HAL');

	if(isset($params['id'])){
		$id = isset($params['id']) ? intval($params['id']) : '';
	}else{
		$id = isset($_REQUEST['id']) ? intval($_REQUEST['id']) : '';
	}
	
 	if(isset($params['name'])){
		$name = isset($params['name']) ? secure_html($params['name']) : '';
	}else{
		$name = isset($_REQUEST['name']) ? secure_html($_REQUEST['name']) : '';
	}

	if($name && $id){
		//$row = $mysql->result("SELECT COUNT(id) FROM ".prefix."_files WHERE name='".db_squote($name)."' AND id='".$id."'");
		$row = $mysql->record('select * from '.prefix.'_files where name='.db_squote($name).' AND id = '.db_squote($id));
	}else{
		msg(array("type" => "error", "text" => 'Такого файла не существует'));
	}

	if(!$row){
		msg(array("type" => "error", "text" => 'Такого файла <b>'.$name.'</b> не существует'));
		return;
	}
		
	if($row){
		if($row['storage'] == 0) {
			$file = $config['files_url'].'/'.$row['folder'].'/'.$row['name'];
		}
		elseif ($row['storage'] == 1) {
			$file = $config['attach_url'].'/'.$row['folder'].'/'.$row['name'];
		}
		
		$mysql->query('update '.prefix.'_files set dcount=dcount+1 where name='.db_squote($row['name']).' AND folder='.db_squote($row['folder']).' AND id = '.db_squote($id).'');

		//$file = ($row['storage'] ? $config['attach_dir'] : $config['files_dir']).$row['folder'].'/'.$row['name'];
		
		$path_info = pathinfo($file);
		$type = $path_info['extension'];
		
		if( $type == "apk" ) $type = "application/vnd.android.package-archive";
		if( $type == "pdf" ) $type = "application/pdf";
		if( $type == "doc" OR $type == "docx") $type = "application/vnd.ms-word";
		if( $type == "mp4" ) $type = "video/mp4";
		if( $type == "torrent" ) $type = "application/x-bittorrent";
		if( $type == "zip" ) $type = "application/zip";
		
		header( 'Last-Modified: '.date("D, d M Y H:i:s T", filemtime('.$file.')) );
		header( "Pragma: public" );
		header( "Expires: 0" );
		header( "Cache-Control: must-revalidate, post-check=0, pre-check=0"); 
		header( "Cache-Control: private", false);
		header( "Content-Type: " . $type );
		header( 'Content-Disposition: attachment; filename="' . $row['name'] . '"' );
		header( "Content-Transfer-Encoding: binary" );

		//header('Location: '.$file);
		
		readfile( $file );
		header( 'Content-Length: '.filesize($file) );
		header("Connection: close");
	}		
	