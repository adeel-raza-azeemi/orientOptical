<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    use HasFactory;

    protected $fillable = [
        'name', 'contact', 'r_sph', 'r_cyl', 'r_aixs', 'l_sph', 'l_cpl', 'l_aixs', 
        'r_sph_multiplier', 'r_cyl_multiplier', 'r_aixs_multiplier', 
        'l_sph_multiplier', 'l_cyl_multiplier', 'l_aixs_multiplier'
    ];
}
