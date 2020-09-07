<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class HasilDataLooger extends Model
{
    public $timestamps = false;
    protected $table = 't_hasil_data_looger';
    protected $guarded = [];
}
