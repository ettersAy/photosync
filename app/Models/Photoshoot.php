<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Photoshoot extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'customer_id',
        'type',
        'description',
        'duration_minutes',
        'price',
        'status',
    ];

    /**
     * Get the customer that owns the photoshoot.
     */
    public function customer(): BelongsTo
    {
        return $this->belongsTo(Customer::class);
    }

    /**
     * Get the appointments for the photoshoot.
     */
    public function appointments(): HasMany
    {
        return $this->hasMany(Appointment::class);
    }
}