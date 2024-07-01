<?php

declare(strict_types=1);

namespace App\Enums;

use BenSampo\Enum\Enum;

/**
 * @method static static OptionOne()
 * @method static static OptionTwo()
 * @method static static OptionThree()
 */
final class Status extends Enum
{
    const REQ = 'req';
    const YES = 'yes';
    const NO = 'no';
    const DELETE = 'delete';
}
