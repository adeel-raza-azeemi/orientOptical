<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Customer_order extends Model
{
    use HasFactory;

    protected $fillable = [
        'customer_id', 'particular', 'order_date', 'total', 'advance',
        'balance', 'frame', 'glasses', 'delivery'
    ];
}
