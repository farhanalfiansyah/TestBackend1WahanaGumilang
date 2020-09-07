<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class Flag extends Model
{
    public $timestamps = false;
    protected $table = 'm_flag';
    protected $guarded = [];
}
