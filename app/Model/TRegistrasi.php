<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class TRegistrasi extends Model
{
    public $timestamps = false;
    protected $table = 't_registrasi';
    protected $guarded = [];
    public static $rules = [
        'data' => ['required'],
    ];
}
