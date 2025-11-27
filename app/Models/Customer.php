<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Customer extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'phone',
        'notes',
    ];

    /**
     * Get the photoshoots for the customer.
     */
    public function photoshoots(): HasMany
    {
        return $this->hasMany(Photoshoot::class);
    }
}