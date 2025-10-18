var _videoData = video_draw();
var _videoStatus = _videoData[0];
var _status = video_get_status();


if (_videoStatus == 0)
{
	if (_status != video_status_playing) { 
		video_resume();
	}
	
    var surf = _videoData[1];
    if (surface_exists(surf))
    {
        draw_surface_stretched(surf, 0, 0, room_width, room_height);
    }
}
else
{
	video_close();
    room_goto(cs_room_goto);
}
